Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULWG3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULWG3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 01:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbULWG3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 01:29:13 -0500
Received: from web51503.mail.yahoo.com ([206.190.38.195]:10073 "HELO
	web51503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261161AbULWG3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 01:29:05 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=SR1+C/9l4cs2hH4tPaf+nvh4dNadsl87IJx9yUnwSbtMcPlG7JlFd+LWYlVk3H4GdqsOifcL+JhUw94hBkMJiIbOFrQK+2Ot9w9IaS2Ymj02xdK2Y9nacqn4TwSXJ8D+bbO32CpFrkteqUyVkofrm2XLKpKUW82acF9LJZ6RbX8=  ;
Message-ID: <20041223062905.20979.qmail@web51503.mail.yahoo.com>
Date: Wed, 22 Dec 2004 22:29:05 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
To: Kausty <kkumbhalkar@gmail.com>
Cc: ipsec@ietf.org, ipsec-tools-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41ae448404122203477e71bb83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004 at 17:17, Kausty wrote:
>
> On Tue, 21 Dec 2004 10:52:22 -0800 (PST), Park Lee
> <parklee_sel@yahoo.com> wrote:
> > Hi,
> > We know that the output process of Linux native
> > IPsec fully uses the XFRM architecture. The order 
> > of primal functions are xfrm_lookup(),
> > xfrm_tmpl_resolve(), xfrm_bundle_create() and
> > dst_output().
> > The input process for IPsec is more simple than
> > output. The order of primal functions (in IPv4) 
> > are xfrm4_rcv(), xfrm4_rcv_encap(),
> > xfrm4_parse_spi(), xfrm4_policy_check().
> >  But, Why should the input process also go 
> > throught xfrm_lookup(), xfrm_tmpl_resolve(),
> > xfrm_bundle_create()? What's the purpose of this?
>
> i havent gone through the code flow as u mentioned 
> but this is my general idea.
>
> these are generic lookup functions irrespective of 
> ipv6/v4.
> the purpose is to ensure that all the SA's are 
> applied hence a bundle needs to be created 
> everytime a packet is recieved.
> If no bundle is created then a seperate search 
> needs to be done for ESP/AH/Transport/Tunnel
>
> is this what u were looking for ??

Thanks.
But, After a packet was received, It has already been
processed by xfrm4_rcv(), xfrm4_rcv_encap(),
ah_input(), esp_input(),etc. so, I think that there is
no need to search(or created) a bundle everytime a
packet is recieved, since it has already been
processed. Am I right?


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
