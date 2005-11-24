Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbVKXHXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVKXHXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKXHXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:23:23 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35975 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030555AbVKXHXW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:23:22 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Use enum to declare errno values
Date: Thu, 24 Nov 2005 09:22:37 +0200
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20051123154423.32867.qmail@web25802.mail.ukl.yahoo.com>
In-Reply-To: <20051123154423.32867.qmail@web25802.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511240922.37535.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 17:44, moreau francis wrote:
> 
> --- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :
> 
> > On Mer, 2005-11-23 at 16:31 +0200, Denis Vlasenko wrote:
> > > Enums are really nice substitute for integer constants instead of #defines.
> > > Enums obey scope rules, #defines do not.
> > > 
> > > However enums are not widely used because of
> > > 1. tradition and style
> > > 2. awkward syntax required:   enum { ABC = 123 };
> > 
> > The SATA layer uses enum for constants and while it was a bit of change
> > in style when I met it, it does seem to work just as well
> 
> I guess we won't use enumeration because it needs to many changes...Each
> function that returns a errno value should have their prototype changed like
> this:
> 
>     int foo(void)
>     {
>             int retval;
>             [...]
>             return retval;
>     }
> 
> should be changed into
> 
>     enum errnoval foo(void)
>     {
>             enum errnoval retval;
>             [...]
>             return retval;
>     }

There exist "unnamed" enums, which do not introduce new type,
just a few symbolic constants of type 'int':

enum /* no name here! */ { A, B, C, D, E };
--
vda
