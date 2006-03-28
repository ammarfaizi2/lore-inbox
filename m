Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWC1Wli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWC1Wli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWC1Wli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:41:38 -0500
Received: from mx0.towertech.it ([213.215.222.73]:7888 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932475AbWC1Wlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:41:37 -0500
Date: Wed, 29 Mar 2006 00:41:22 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Added support for ds1672 control
Message-ID: <20060329004122.64e91176@inspiron>
In-Reply-To: <08A09790-5D74-4089-AA7B-6AB5628A19DD@kernel.crashing.org>
References: <Pine.LNX.4.44.0603281507050.20373-100000@gate.crashing.org>
	<20060328234027.26b5602b@inspiron>
	<08A09790-5D74-4089-AA7B-6AB5628A19DD@kernel.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 16:04:20 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> Not sure if I follow you here.  I think you are suggesting for  
> ds1672_get_control to look like:
> 
> static int ds1672_get_control(struct i2c_client *client, u8 *status)
> {
>          unsigned char addr = DS1672_REG_CONTROL;
> 
>          struct i2c_msg msgs[] = {
>                  { client->addr, 0, 1, &addr },          /* setup  
> read ptr */
>                  { client->addr, I2C_M_RD, 1, status },  /* read  
> control */
>          };
> ...
> }

 yes.


> which is fine.  Any suggestions on what to do on an error in the  
> sysfs attrib function?

 i2c_transfer will give the errno to return back.
 This remembers me that I forgot to do that in other drivers :(

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

