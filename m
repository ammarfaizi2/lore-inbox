Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWFAGS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWFAGS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWFAGS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:18:28 -0400
Received: from gw.openss7.com ([142.179.199.224]:53394 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751813AbWFAGS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:18:27 -0400
Date: Thu, 1 Jun 2006 00:18:25 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601001825.A21730@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601060424.GA28087@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Jun 01, 2006 at 10:04:24AM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 01 Jun 2006, Evgeniy Polyakov wrote:
> 	
> 	for (i=0; i<hash_size*iter_num; ++i) {
> 		saddr = num2ip(get_random_byte(), get_random_byte(), get_random_byte(), get_random_byte());
> 		sport = get_random_word();

You still have a problem: you cannot use a pseudo-random number
generator to generate the sample set as the pseudo-random number
generator function itself can interact with the hash.

Try iterating through all 2**48 values or at least a sizeable
representative subset.

