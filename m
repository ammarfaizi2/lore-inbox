Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSIERj2>; Thu, 5 Sep 2002 13:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSIERj2>; Thu, 5 Sep 2002 13:39:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:49670 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317434AbSIERj2>; Thu, 5 Sep 2002 13:39:28 -0400
Date: Thu, 5 Sep 2002 18:43:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, paulkf@microgate.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix .text.exit error with static compile of synclinkmp.c
Message-ID: <20020905184359.A9907@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, paulkf@microgate.com,
	linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0209051931430.7218-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0209051931430.7218-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Thu, Sep 05, 2002 at 07:36:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that the __exit function synclinkmp_remove_one is referred
> to in "static struct pci_driver synclinkmp_pci_driver".
> 
> The fix is simple:

And wrong.  Please use __devexit_p() instead.

