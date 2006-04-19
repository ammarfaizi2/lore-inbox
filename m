Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWDSWTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDSWTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWDSWS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:18:59 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:28635 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751141AbWDSWS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:18:58 -0400
X-ME-UUID: 20060419221857512.7D133700008E@mwinf1309.wanadoo.fr
Date: Thu, 20 Apr 2006 00:17:56 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: class_device_add error in SCSI with 2.6.17-rc2-g52824b6b
Message-ID: <20060419221756.GA12149@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419215803.6DE5BDBA1@gherkin.frus.com>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 04:58:03PM -0500, Bob Tracy wrote:
> Similar error previously reported by me for 2.6.17-rc1, except sda got
> added fine: error occurred when attempting to add/register sdb. 

Actually you're right. I'm rereading the logs and the first device on a
scsi bus is always registered correctly. The sh*t hits the fan when you
have more than one sd device per bus. (I've got 2 devices on one, and 3
on the other and only the first one on each got registered correctly).

> Thankfully, you were able to append a trace...

I used the serial console.

> I'll be trying the just-released 2.6.17-rc2 this evening.  Report to
> follow, and if there's a problem, I'll attempt to provide the trace
> (will have to be transcribed by hand, as system won't come up far
> enough for syslog to capture anything).

If syslog doesn't come up and depending on the state of your system you
could redirect dmesg output to a file.
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

