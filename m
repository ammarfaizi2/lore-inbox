Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbREXO7q>; Thu, 24 May 2001 10:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbREXO7g>; Thu, 24 May 2001 10:59:36 -0400
Received: from 3-020.ctame701-2.telepar.net.br ([200.181.171.20]:52487 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S262067AbREXO7T>; Thu, 24 May 2001 10:59:19 -0400
Date: Thu, 24 May 2001 11:59:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: praveens@stanford.edu (Praveen Srinivasan), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Re: [PATCH] bulkmem.c - null ptr fixes for 2.4.4
Message-ID: <20010524115920.D3068@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	praveens@stanford.edu (Praveen Srinivasan), torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 24, 2001 at 03:26:20PM +0100, Alan Cox escreveu:
> > kernel code. This patch fixes numerous unchecked pointers in the PCMCIA 
> > bulkmem driver. 
> 
> Since when has two been numerous - also I dont thin the fix is right - you need
> to undo what has already been done

and anyway, 2.4.4-ac15 already has the checks, it just doesnt deallocates
what's have already been inserted in the list in setup_regions, the memory
doesn't seem to get lost, but I think its better deallocate whats been
done if it fails halfway in setup_regions.

- Arnaldo
