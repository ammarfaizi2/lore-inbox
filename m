Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTGBUUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTGBUUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:20:13 -0400
Received: from buerotecgmbh.de ([217.160.181.99]:59535 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S264478AbTGBUUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:20:09 -0400
Date: Wed, 2 Jul 2003 22:34:33 +0200
From: Kay Sievers <lkml001@vrfy.org>
To: linux-kernel@vger.kernel.org
Subject: why does sscanf() does not interpret number length attributes?
Message-ID: <20030702203433.GA14854@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed a conversion from hex-string to integer and found
this mail from Linus suggesting sscanf:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101414195507893&w=2

but sscanf in linux-2.5/lib/vsprintf.c interpretes length attributes
only when the type is a string. It uses simple_strtoul() and it will
read the buffer until it finds a non-(hex)digit.

int i;
char str[] ="34AFFE45XYZ";
sscanf(str, "%1x", &i);

i will be '0x34AFFE45' instead of the expected '3'.

Is this behaviour intended or is just nobody caring about?


thanks
Kay

