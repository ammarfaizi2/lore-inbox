Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbRENTRk>; Mon, 14 May 2001 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbRENTRa>; Mon, 14 May 2001 15:17:30 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:36764 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S262392AbRENTRS>; Mon, 14 May 2001 15:17:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] proc fs extension for "one-value-per-file"
Date: Mon, 14 May 2001 20:59:33 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01051420593300.00951@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch extends the proc fs api as discussed in the thread "/proc 
format" last month (http://marc.theaimsgroup.com/?t=98822545000007&w=2&r=1). 

It adds the following features:
- dynamic directories. Enables you to use directories for enumerations, 
similar to the per-process directories (/proc/<number>) or usbdevfs. 
- context callbacks for directories. They can do things that are common for 
all files in a directory, like locking, and are also used for dynamic 
directories.
- special functions with context support for proc files that containing short 
strings, integers or enums

These things give the proc filesystem the functionality that I need for the 
Device Registry patch to replace the XML output with the one-value-per-file 
approach. The api is documented in fs/proc/onevalue.c. 

You can download the patch for 2.4.4 here (40 kB):
http://www.tjansen.de/devreg/proc_ov-2.4.4.diff

bye...

