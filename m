Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270664AbTG0E0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270667AbTG0E0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:26:10 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:59532 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270664AbTG0EZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:25:41 -0400
Message-Id: <5.1.0.14.2.20030727061608.00a77960@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 27 Jul 2003 06:42:12 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: ZqYoj0ZAwef+RwExp-73iKWni8PV+TXKINbHrz1lVWhXbJ7hdMoYgs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Attached is patch against 2.6.0-test1 that adds type_name to all in-tree
 > sensors; it sets it to the same values as corr. 2.4 senors and (in one case)
 > changes client name to match that of 2.4.

Well, it certainly doesn't with the lm85.c  :-)
Hint - names are in lib/chips.h in sensors package :-)

Although, I will be working over lm85.c in the next week or so.

 > +static const char *type_name = "";
 > +static ssize_t show_type_name(struct device *dev, char *buf)
 > +{
 > + return sprintf(buf, "%s\n", type_name);
 > +}
 > +static DEVICE_ATTR(type_name, S_IRUGO, show_type_name, NULL);

 > - const char *type_name = "";

 > + device_create_file(&new_client->dev, &dev_attr_type_name);



Margit 

