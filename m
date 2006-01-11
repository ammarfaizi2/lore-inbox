Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWAKP7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWAKP7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWAKP7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:59:14 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:59492 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750864AbWAKP7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:59:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=c7bNuj5bdFlBMRqJp6NAZ2Bjc0UgNcGGFoRAr69E2zgUliI+fmlDVkMhaBnCadnhn9mdHozU3/fDsMh/epYOcVJGDqd1jCi4QogLvPMU6Vhb287I/cLbOVUuyRes51zt4R74KCWLkbaOKb4QTv3AlRn/g4MtyGKckhrZokG4y8k=
Date: Wed, 11 Jan 2006 19:16:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix "stuct", "strut", "struc" typos
Message-ID: <20060111161610.GG8686@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/DocBook/videobook.tmpl                         |    4 ++--
 Documentation/input/ff.txt                                   |    2 +-
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 +-
 drivers/char/rio/port.h                                      |    2 +-
 drivers/char/rio/riotty.c                                    |    2 +-
 drivers/net/wan/lmc/lmc_main.c                               |    2 +-
 drivers/scsi/FlashPoint.c                                    |    2 +-
 include/asm-v850/ptrace.h                                    |    2 +-
 include/linux/pfkeyv2.h                                      |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

--- a/Documentation/DocBook/videobook.tmpl
+++ b/Documentation/DocBook/videobook.tmpl
@@ -229,7 +229,7 @@ int __init myradio_init(struct video_ini
 
 static int users = 0;
 
-static int radio_open(stuct video_device *dev, int flags)
+static int radio_open(struct video_device *dev, int flags)
 {
         if(users)
                 return -EBUSY;
@@ -949,7 +949,7 @@ int __init mycamera_init(struct video_in
 
 static int users = 0;
 
-static int camera_open(stuct video_device *dev, int flags)
+static int camera_open(struct video_device *dev, int flags)
 {
         if(users)
                 return -EBUSY;
--- a/Documentation/input/ff.txt
+++ b/Documentation/input/ff.txt
@@ -120,7 +120,7 @@ to the unique id assigned by the driver.
 some operations (removing an effect, controlling the playback).
 This if field must be set to -1 by the user in order to tell the driver to
 allocate a new effect.
-See <linux/input.h> for a description of the ff_effect stuct. You should also
+See <linux/input.h> for a description of the ff_effect struct. You should also
 find help in a few sketches, contained in files shape.fig and interactive.fig.
 You need xfig to visualize these files.
 
--- a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
@@ -5577,7 +5577,7 @@ struct _snd_pcm_runtime {
       <informalexample>
         <programlisting>
 <![CDATA[
-  static int mychip_suspend(strut pci_dev *pci, pm_message_t state)
+  static int mychip_suspend(struct pci_dev *pci, pm_message_t state)
   {
           /* (1) */
           struct snd_card *card = pci_get_drvdata(pci);
--- a/drivers/char/rio/port.h
+++ b/drivers/char/rio/port.h
@@ -223,7 +223,7 @@ struct	Port
 	int				timeout_id;	/* For calling 100 ms delays */
 	int				timeout_sem;/* For calling 100 ms delays */
 	int				firstOpen;	/* First time open ? */
-	char *			p;			/* save the global struc here .. */
+	char *			p;			/* save the global struct here .. */
 };
 
 struct ModuleInfo
--- a/drivers/char/rio/riotty.c
+++ b/drivers/char/rio/riotty.c
@@ -192,7 +192,7 @@ riotopen(struct tty_struct * tty, struct
 	/*
 	** Grab pointer to the port stucture
 	*/
-	PortP = p->RIOPortp[SysPort];	/* Get control struc */
+	PortP = p->RIOPortp[SysPort];	/* Get control struct */
 	rio_dprintk (RIO_DEBUG_TTY, "PortP: %p\n", PortP);
 	if ( !PortP->Mapped ) {	/* we aren't mapped yet! */
 		/*
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -641,7 +641,7 @@ static void lmc_watchdog (unsigned long 
     spin_lock_irqsave(&sc->lmc_lock, flags);
 
     if(sc->check != 0xBEAFCAFE){
-        printk("LMC: Corrupt net_device stuct, breaking out\n");
+        printk("LMC: Corrupt net_device struct, breaking out\n");
 	spin_unlock_irqrestore(&sc->lmc_lock, flags);
         return;
     }
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -149,7 +149,7 @@ typedef SCCBMGR_INFO *      PSCCBMGR_INF
 #define PCI_BUS_CARD          0x03
 #define VESA_BUS_CARD         0x04
 
-/* SCCB struc used for both SCCB and UCB manager compiles! 
+/* SCCB struct used for both SCCB and UCB manager compiles! 
  * The UCB Manager treats the SCCB as it's 'native hardware structure' 
  */
 
--- a/include/asm-v850/ptrace.h
+++ b/include/asm-v850/ptrace.h
@@ -92,7 +92,7 @@ struct pt_regs
 /* The number of bytes used to store each register.  */
 #define _PT_REG_SIZE	4
 
-/* Offset of a general purpose register in a stuct pt_regs.  */
+/* Offset of a general purpose register in a struct pt_regs.  */
 #define PT_GPR(num)	((num) * _PT_REG_SIZE)
 
 /* Offsets of various special registers & fields in a struct pt_regs.  */
--- a/include/linux/pfkeyv2.h
+++ b/include/linux/pfkeyv2.h
@@ -104,7 +104,7 @@ struct sadb_prop {
 /* followed by:
 	struct sadb_comb sadb_combs[(sadb_prop_len +
 		sizeof(uint64_t) - sizeof(struct sadb_prop)) /
-		sizeof(strut sadb_comb)]; */
+		sizeof(struct sadb_comb)]; */
 
 struct sadb_comb {
 	uint8_t		sadb_comb_auth;

