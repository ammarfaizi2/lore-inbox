Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSJQB3b>; Wed, 16 Oct 2002 21:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJQB3b>; Wed, 16 Oct 2002 21:29:31 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:38158 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261615AbSJQB3a>; Wed, 16 Oct 2002 21:29:30 -0400
Date: Wed, 16 Oct 2002 22:35:22 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one record per call
Message-ID: <20021017013522.GU7541@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021017010135.GR7541@conectiva.com.br> <20021016.175809.28811497.davem@redhat.com> <20021017011108.GT7541@conectiva.com.br> <20021016.181550.88499112.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.181550.88499112.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2002 at 06:15:50PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Wed, 16 Oct 2002 22:11:08 -0300
> 
>    That would be nice, yes, bastardizing pos for this is, humm, ugly, and
>    it isn't accessible at show time (pun intended 8) ).
> 
> Can you remind me what the original objection was to
> just using seq->private?  Is it used, or planned to
> be used, by something else?

lemme get my logs... here it is:

Quoting Al:

"You're free to use, but keep in mind that it's assumed to be constant over
->start/->stop/->next/->show more accurately, there's no sane way to use it as
part of iterator state it's for "which of iterators with similar code it is?"
e.g. /proc/<pid>/mounts uses the same iterator over different namespaces -
depending on pid.  take a look at the way /proc/ksyms is done"

- Arnaldo
