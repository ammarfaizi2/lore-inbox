Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWDGVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWDGVqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWDGVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:46:50 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:47754 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932451AbWDGVqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:46:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=lXDcqwzk7OMQDEZ7kS3eLiudVPPHiTchsAkcCqrwBFHLVu5/bsAHZ+uNrfSrmfzFNv24z3SD/B1Ls8n6AiByQO0P/MuyS7ZVy1Zxks1in8O1mVKS+Ygd2iwGahd/WAfGkv9sZjyPzy309v6OWoD5BP4YB4590Oy0KqhcrR/GbvQ=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 03/17] uml: fix 2 harmless cast warnings for 64-bit
Date: Fri, 7 Apr 2006 23:46:44 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060407142709.19201.99196.stgit@zion.home.lan> <20060407143054.19201.89200.stgit@zion.home.lan> <20060407160218.GA4962@ccure.user-mode-linux.org>
In-Reply-To: <20060407160218.GA4962@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072346.45225.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 18:02, Jeff Dike wrote:
> On Fri, Apr 07, 2006 at 04:30:54PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Fix two harmless warnings in 64-bit compilation (the 2nd doesn't trigger
> > for now because of a missing __attribute((format)) for cow_printf, but
> > next patches fix that).

> I don't object to this bit, but it doesn't seem to match the comment.  Was
> there another cast that you meant to have here, but missed?

No, the below one was a whitespace change which slipped in without mention 
(but that I confirm).

> > -		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
> > +		n = min((size_t) len, ARRAY_SIZE(console_buf) - console_index);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
