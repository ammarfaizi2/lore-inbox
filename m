Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVEQGlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEQGlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEQGlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:41:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:3755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261228AbVEQGlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:41:52 -0400
X-Authenticated: #23875046
From: Alexey Fisher <fishor@gmx.net>
Reply-To: fishor@gmx.net
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: clean up and warnings patch for 2.6.12-rc4-mm1 i2c-chip
Date: Tue, 17 May 2005 08:41:19 +0200
User-Agent: KMail/1.8
References: <200505160014.36016.fishor@gmx.net> <20050516191942.0cd51155.khali@linux-fr.org>
In-Reply-To: <20050516191942.0cd51155.khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170841.20079.fishor@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean
with module w83627hf  i found useful due  detection return -ENODEV
because I can see in commandline if it's some thing wrong. If it's not correct, there is a bug 
in the w83627hf and some other drivers.



int w83627hf_detect(struct i2c_adapter *adapter, int address,
                   int kind)
{
        int val;
        struct i2c_client *new_client;
        struct w83627hf_data *data;
        int err = 0;
        const char *client_name = "";

        if (!i2c_is_isa_adapter(adapter)) {
                err = -ENODEV;
                goto ERROR0;
        }
