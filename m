Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281029AbRLDRe0>; Tue, 4 Dec 2001 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRLDRP7>; Tue, 4 Dec 2001 12:15:59 -0500
Received: from air-1.osdl.org ([65.201.151.5]:1798 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281199AbRLDRO4>;
	Tue, 4 Dec 2001 12:14:56 -0500
Date: Tue, 4 Dec 2001 09:11:06 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Kousalya K <kkasinat@npd.hcltech.com>
cc: <linux-kernel@vger.kernel.org>, <sagundu@npd.hcltech.com>
Subject: Re: scsi_dev_init who is calling & where its defined?
In-Reply-To: <3C0B57A9.61A64740@npd.hcltech.com>
Message-ID: <Pine.LNX.4.33L2.0112040902260.18921-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2001, Kousalya K wrote:

| Hi all,
|
| I'm trying to find out how linux kernel calls scsi_dev_init  function
| after kernel image is loaded.
| I got information  from web that , the sequence is,

What web page/URL?  What Linux kernel version is it for?
I'm just guessing that it's out of date.

| "init() will call do_basic_setup() which inturn will call
|         device_setup()-> scsi_dev_init()->scsi_init()"
|
| /* init() and device_setup() are definied in main.c */

init() calls do_basic_setup(), which calls do_initcalls(),
which calls all module_init() functions for "modules"
that are built into the kernel, including scsi_init() if
SCSI is built into the kernel (instead of being a loadable
module).

| But I'm not able to find out the function call for device_setup()
| (defined in /usr/src/linux-2.4.2/drivers/char/pcmcia/serial_ cb.c)
| function from  do_basic_setup() function.
|
| device_setup function is not at all calling any scsi related functions.

Yes, there are some (other) device_setup() functions: pcmcia serial
and wanrouter, but not in scsi.

| Could anyone please tell me the flow of how scsi_dev_init is called,
| which inturn call what are all the functions?

Above, except omitting "scsi_dev_init".

| Could you please provide the the location of the file where the
| scsi_dev_init  and  scsi_init function is defined?

scsi_dev_init() doesn't seem to exist (in 2.4.16).
scsi_init() is in linux/drivers/scsi/scsi.c .

| /* In  linux-2.4.9 kernel, I'm not able to find  out function
| device_setup and also the file serial_cb.c
| Any ideas?  */

-- 
~Randy

