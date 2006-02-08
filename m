Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWBHMqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWBHMqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWBHMqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:46:55 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:40163 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161082AbWBHMqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:46:54 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E9E966.9060003@s5r6.in-berlin.de>
Date: Wed, 08 Feb 2006 13:51:50 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add execute_in_process_context() API
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.86) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> SCSI needs this for our scheme to avoid executing generic device release
> calls from interrupt context (SCSI patch using this to follow).

Shouldn't we rather fix the SCSI low level drivers or SCSI transport 
layers to trigger device releases only from process context? (Instead of 
SCSI core transparently falling back to a workqueue, that is.)

I know only one of these drivers, hence I don't know which are actually 
affected and how much work that would be.
-- 
Stefan Richter
-=====-=-==- --=- -=---
http://arcgraph.de/sr/

