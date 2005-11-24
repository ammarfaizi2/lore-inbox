Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVKXJoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVKXJoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVKXJoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:44:16 -0500
Received: from denise.shiny.it ([194.20.232.1]:64901 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S1751346AbVKXJoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:44:14 -0500
Message-ID: <XFMail.20051124104334.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200511231631.12365.vda@ilport.com.ua>
Date: Thu, 24 Nov 2005 10:43:34 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Use enum to declare errno values
Cc: linux-kernel@vger.kernel.org, moreau francis <francis_moreau2000@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23-Nov-2005 Denis Vlasenko wrote:
> On Wednesday 23 November 2005 15:24, moreau francis wrote:
>> Hi,
>>  
>> I'm just wondering why not declaring errno values using enumaration ? It is 
>> just more convenient when debuging the kernel.
> 
> Enums are really nice substitute for integer constants instead of #defines.
> Enums obey scope rules, #defines do not.
> 
> However enums are not widely used because of
> 1. tradition and style
> 2. awkward syntax required:   enum { ABC = 123 };

The value of an enum constant must be representable as an int. This
is not always the case, expecially with hardware constants and bit
masks, which may require an unsigned int.


--
Giuliano.
