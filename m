Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWFBRh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWFBRh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBRh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:37:56 -0400
Received: from gw.openss7.com ([142.179.199.224]:54470 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751348AbWFBRhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:37:54 -0400
Date: Fri, 2 Jun 2006 11:37:53 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060602113753.A20836@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <87y7wgaze1.fsf@mid.deneb.enyo.de> <20060602074845.GA17798@2ka.mipt.ru> <87ac8v8o4i.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87ac8v8o4i.fsf@mid.deneb.enyo.de>; from fw@deneb.enyo.de on Fri, Jun 02, 2006 at 07:26:53PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian,

On Fri, 02 Jun 2006, Florian Weimer wrote:
> 
> I see them now.  Hmm.  Is there a theoretical explanation for them?

Jenkins is an ad hoc function that is far from ideal.  As you know,
the ideal hash changes 1/2 the bits in the output value for each one
bit change in the input value(s).  Jenkins changes a few as 1/3 and
performs less than ideal over even a small smaple of the input data
set (Jenkins said he checked several billion of the trilions of
changes).

It should not be suprising that a general purpose ad hoc function
(Jenkins) performs poorer than a specific purpose ad hoc function
(XOR), for the very specific input data sets that the later was chosen
to cover.

Theoretically, XOR can be improved upon, but Jenkins doesn't do it.
