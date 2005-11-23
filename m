Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVKWPoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVKWPoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVKWPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:44:30 -0500
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:65419 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751053AbVKWPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:44:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3Kl+w61iGloBEs3IiqUL1BwgNGtpY2bTk+9qnOUqL6TPwVaLHIcu/oS0OmGO7gwxu6hKvYUsOfXITQraZ9zUmT0chTtpeAezGcl6EkHbAifIW5DQ2oCGKDs97ZObDyTWHRD54aAaVcORaxg34SZKz+0f2cMXyXJlk4+9IO/DO+Q=  ;
Message-ID: <20051123154423.32867.qmail@web25802.mail.ukl.yahoo.com>
Date: Wed, 23 Nov 2005 16:44:23 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Use enum to declare errno values
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Denis Vlasenko <vda@ilport.com.ua>
Cc: moreau francis <francis_moreau2000@yahoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <1132758910.7268.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit :

> On Mer, 2005-11-23 at 16:31 +0200, Denis Vlasenko wrote:
> > Enums are really nice substitute for integer constants instead of #defines.
> > Enums obey scope rules, #defines do not.
> > 
> > However enums are not widely used because of
> > 1. tradition and style
> > 2. awkward syntax required:   enum { ABC = 123 };
> 
> The SATA layer uses enum for constants and while it was a bit of change
> in style when I met it, it does seem to work just as well
> 
> 

I guess we won't use enumeration because it needs to many changes...Each
function that returns a errno value should have their prototype changed like
this:

    int foo(void)
    {
            int retval;
            [...]
            return retval;
    }

should be changed into

    enum errnoval foo(void)
    {
            enum errnoval retval;
            [...]
            return retval;
    }


Thanks


	
	
		
___________________________________________________________________________
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
