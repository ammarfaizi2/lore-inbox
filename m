Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTHWSeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbTHWSeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 14:34:18 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:36104 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264280AbTHWSeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 14:34:01 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-bk8: sensor chips write value problem
Date: Sat, 23 Aug 2003 22:34:05 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308232232.39261.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using ASUS as99127f chip, attempt to write any value in in_minN or in_maxN 
results in funny value set:

{pts/1}% cat /sys/bus/i2c/devices/0-002d/in_*2
3472
3632
2976
{pts/1}% sudo zsh -c 'echo 3000 > /sys/bus/i2c/devices/0-002d/in_min2'
{pts/1}% cat /sys/bus/i2c/devices/0-002d/in_*2
3472
3632
400

{pts/1}% cat /sys/bus/i2c/devices/0-002d/name
as99127f
{pts/1}% cat /sys/class/i2c-adapter/i2c-0/device/name
SMBus I801 adapter at e800

the same runs just fine under 2.4 (with libsensors).

also, setting temp_{min.max}N works just fine under 2.6

-andrey
