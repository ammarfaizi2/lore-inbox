Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLQI4g>; Sun, 17 Dec 2000 03:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLQI41>; Sun, 17 Dec 2000 03:56:27 -0500
Received: from pop.gmx.net ([194.221.183.20]:39254 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129408AbQLQI4R>;
	Sun, 17 Dec 2000 03:56:17 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Sun, 17 Dec 2000 09:22:04 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>, f5ibh <f5ibh@db0bm.ampr.org>
In-Reply-To: <14735.976963083@ocs3.ocs-net>
In-Reply-To: <14735.976963083@ocs3.ocs-net>
Subject: Re: 2.4.0-test13-pre2, unresolved symbols
MIME-Version: 1.0
Message-Id: <00121709220400.00938@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

having applied your patch below + modutils2.3.23-1 + kernel2.4.0-test13pre2 
all seems to run perfect. 
But when starting kwintv  /dev/video is not found. /dev/video is a symling on 
/dev/video0 and with kernel kernel2.4.0-test12 there is no problem at all.


>can't open /dev/video: Kein passendes Gerät gefunden
>Warning: kwintv: kv4lsetup had some trouble, trying to continue anyway.
>Debug: v4l1: Using interface Video4Linux in ::v4lxif
>Fatal: v4lx: Error opening v4lx device /dev/video: Kein passendes Gerät 
>gefunden in ::v4lxif


BTW: I have still to patch 8139too.c as you told me before (I did it 
manually).

kind regards
Norbert




On Saturday 16 December 2000 11:38, Keith Owens wrote:
> On Sat, 16 Dec 2000 11:32:44 +0100,
>
> f5ibh <f5ibh@db0bm.ampr.org> wrote:
> >/lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
> >/lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o: unresolved symbol
> > rpc_wake_up_task
>
> Does this fix it?
>
> Index: 0-test13-pre2.1/fs/lockd/svc.c
> --- 0-test13-pre2.1/fs/lockd/svc.c Mon, 02 Oct 2000 15:28:44 +1100 kaos
> (linux-2.4/e/b/39_svc.c 1.1.1.2 644) +++ 0-test13-pre2.1(w)/fs/lockd/svc.c
> Sat, 16 Dec 2000 21:26:35 +1100 kaos (linux-2.4/e/b/39_svc.c 1.1.1.2 644)
> @@ -312,7 +312,6 @@ out:
>  #ifdef MODULE
>  /* New module support in 2.1.18 */
>
> -EXPORT_NO_SYMBOLS;
>  MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
>  MODULE_DESCRIPTION("NFS file locking service version " LOCKD_VERSION ".");
>  MODULE_PARM(nlm_grace_period, "10-240l");
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
