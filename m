Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVCZUPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVCZUPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 15:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCZUPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 15:15:41 -0500
Received: from mail.europlex.ie ([83.141.76.10]:54961 "EHLO
	eurodubx.europlex.local") by vger.kernel.org with ESMTP
	id S261245AbVCZUPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 15:15:34 -0500
Message-ID: <4245C711.2040304@eircom.net>
Date: Sat, 26 Mar 2005 20:33:21 +0000
From: "Bryan O'Donoghue" <typedef@eircom.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: arc/arm/config.in still broken 2.4.19-2.4.29 ?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2005 20:22:12.0890 (UTC) FILETIME=[7EA47FA0:01C53241]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings list.

arch/arm/config.in has an error which breaks make.

I've googled this a bit just by searching for drivers/ssi/Config.in and the 
first reference I find to this breakage is in 2002 !

For completeness shouldn't this really be removed once and for all?

I'm not clear on what the procedure is for submitting a patch, but, I've 
included one to save somebody else the bother.

Best
Bryan


diff -puN linux-2.4.29/arch/arm/config.in linux-2.4.30-rc2/arch/arm/config.in

--- linux-2.4.29/arch/arm/config.in     2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.30-rc2/arch/arm/config.in 2005-03-26 20:11:54.000000000 +0000
@@ -599,11 +599,6 @@ if [ "$CONFIG_SCSI" != "n" ]; then
  fi
  endmenu

-if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then
-   # This is _meant_ to be ssi _not_ scsi.  It is not a spelling error.
-   source drivers/ssi/Config.in
-fi
-
  source drivers/ieee1394/Config.in

  source drivers/message/i2o/Config.in
