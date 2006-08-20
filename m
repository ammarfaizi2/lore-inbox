Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWHTVtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWHTVtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWHTVtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 17:49:20 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:23958 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751170AbWHTVtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 17:49:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=L0rMLcPiPF1v1wDIcmcwcqWOGfu9FDeYQZrZG1C7PUOZk6c8BoBp23l5GTK3nKSGlft0AbIcMRTnXO74/+96I+ZYYOIoRzCnCjvtBIxqq8oWJGuJtHCxDBmJRLradZgApptifflzoOef0VD/zw/NTyC4R98I0PiKlubXYl7yTwI=
Message-ID: <44E8D8F7.5090000@yahoo.com>
Date: Sun, 20 Aug 2006 15:49:43 -0600
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>,
       Philip Edelbrock <phil@netroedge.com>,
       Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
References: <44E8C9AE.3060307@gmail.com>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: jim.cromie@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
>
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
>
> w83627hf.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 80 insertions(+), 16 deletions(-)
>
> Regards,
> Michal
>
>   

Ouch.

Ideally, you should have checked here (LM-Sensors ML) 1st.
The driver you chose has already been reworked along those lines,
and accepted by Jean Delvare, and thus slated for .19

an early copy (8/02)
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017043.html

If youre so inclined, there are ~38 others in need
of similar attention ;)



<cp-pasted from ML thread>
Here is asb100.c... I'll add lm75, lm78, smsc47b397, and w83627hf
to this patch as I have time.  (Jean: don't apply yet.)

pc87360 (one of the larger offenders) is also now fixed.


Im sure if you ask nicely, Jean will provide you with
a current/authoritative list ;-)


http://khali.linux-fr.org/devel/i2c/linux-2.6/?M=A
has a fairly current collection and series-file (8/14/06)
Unfortunately, the series doesnt enumerate the patches
as a set, and several accepted patches arent there yet.
Jean, is this still the best/good place to keep current ?

