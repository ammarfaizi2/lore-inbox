Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265557AbSJSJAy>; Sat, 19 Oct 2002 05:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265561AbSJSJAy>; Sat, 19 Oct 2002 05:00:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265557AbSJSJAx>;
	Sat, 19 Oct 2002 05:00:53 -0400
Date: Sat, 19 Oct 2002 11:06:37 +0200
From: Jens Axboe <axboe@suse.de>
To: haoviet@tuluc.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 compilation errors
Message-ID: <20021019090637.GE871@suse.de>
References: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33182.24.130.42.133.1035014240.squirrel@mail.tuluc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19 2002, haoviet@tuluc.com wrote:
> --------------------------------------------------------------------------
> drivers/scsi/qla1280.c:5932: unknown field `next' specified in initializer
> drivers/scsi/qla1280.c:5932: warning: missing braces around initializer
> drivers/scsi/qla1280.c:5932: warning: (near initialization for
> `driver_template.shtp_list')make[2]: *** [drivers/scsi/qla1280.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
> ----------------------------------------------------------------------------

===== drivers/scsi/qla1280.h 1.7 vs edited =====
--- 1.7/drivers/scsi/qla1280.h	Mon Oct 14 19:00:37 2002
+++ edited/drivers/scsi/qla1280.h	Sat Oct 19 11:05:46 2002
@@ -1324,22 +1324,12 @@
  */
 
 #define QLA1280_LINUX_TEMPLATE {				\
-	next: NULL,						\
-	module: NULL,						\
-	proc_dir: NULL,						\
 	proc_info: qla1280_proc_info,				\
 	name: "Qlogic ISP 1280/12160",				\
 	detect: qla1280_detect,					\
 	release: qla1280_release,				\
 	info: qla1280_info,					\
-	ioctl: NULL,						\
-	command: NULL,						\
 	queuecommand: qla1280_queuecommand,			\
-	eh_strategy_handler: NULL,				\
-	eh_abort_handler: NULL,					\
-	eh_device_reset_handler: NULL,				\
-	eh_bus_reset_handler: NULL,				\
-	eh_host_reset_handler: NULL,				\
 /*	use_new_eh_code: 0, */					\
 	abort: qla1280_abort,					\
 	reset: qla1280_reset,					\


-- 
Jens Axboe

