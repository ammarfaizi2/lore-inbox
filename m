Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVIZTbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVIZTbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVIZTbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:31:31 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:22047 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751370AbVIZTb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:31:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=czgfEOIBWMaz+FXrqi7pnKLpHmfbyAZcQQzmOuBukNYkfY1h5djuuqda0Q4NCdDoAdWzybVhB4qKo3EwpB49LAo/3+8zpfTZl8juyQ2ZtOja6398Apg+MhstZW/tPOu2UmlXQNh8246EzsUqFrcN33eo+C0rD/+tt+vWBjNDDE0=
Date: Mon, 26 Sep 2005 23:42:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Documentation/ioctl-mess.txt: fill more holes in B-P range
Message-ID: <20050926194222.GB32409@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also add a couple of PMU_IOC_* with types of their input and output.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/ioctl-mess.txt | 1653 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 1336 insertions(+), 317 deletions(-)

--- a/Documentation/ioctl-mess.txt
+++ b/Documentation/ioctl-mess.txt
@@ -330,26 +330,80 @@ N: AUTOFS_IOC_TOGGLEREGHOST
 I: int
 O: -
 
-BIODASDCMFDISABLE
-BIODASDCMFENABLE
-BIODASDDISABLE
-BIODASDENABLE
-BIODASDFMT
-BIODASDFORMAT
-BIODASDGATTR
-BIODASDINFO
-BIODASDINFO2
-BIODASDPRRD
-BIODASDPRRST
-BIODASDPSRD
-BIODASDQUIESCE
+N: BIODASDCMFDISABLE
+I: -
+O: -
+
+N: BIODASDCMFENABLE
+I: -
+O: -
+
+N: BIODASDDISABLE
+I: -
+O: -
+
+N: BIODASDENABLE
+I: -
+O: -
+
+N: BIODASDFMT
+I: struct format_data_t
+O: -
+
+N: BIODASDFORMAT
+I: -
+O: struct attrib_data_t
+
+N: BIODASDGATTR
+I: -
+O: struct attrib_data_t
+
+N: BIODASDINFO
+I: -
+O: struct dasd_information_t
+
+N: BIODASDINFO2
+I: -
+O: struct dasd_information2_t
+
+N: BIODASDPRRD
+I: -
+O: struct dasd_profile_info_t
+
+N: BIODASDPRRST
+I: -
+O: -
+
+N: BIODASDPSRD
+I: -
+O: struct dasd_rssd_perf_stats_t
+
+N: BIODASDQUIESCE
+I: -
+O: -
+
 BIODASDREADALLCMB
 BIODASDRESETCMB
-BIODASDRESUME
-BIODASDRLSE
-BIODASDRSRV
-BIODASDSATTR
-BIODASDSLCK
+
+N: BIODASDRESUME
+I: -
+O: -
+
+N: BIODASDRLSE
+I: -
+O: -
+
+N: BIODASDRSRV
+I: -
+O: -
+
+N: BIODASDSATTR
+I: struct attrib_data_t
+O: -
+
+N: BIODASDSLCK
+I: -
+O: -
 
 N: BLKBSZGET
 I: -
@@ -582,10 +636,50 @@ N: CA_SET_PID
 I: -
 O: -
 
+N: CCISS_BIG_PASSTHRU
+I: BIG_IOCTL_Command_struct
+O: BIG_IOCTL_Command_struct
+
 N: CCISS_DEREGDISK
 I: -
 O: -
 
+N: CCISS_GETBUSTYPES
+I: -
+O: BusTypes_type
+
+N: CCISS_GETDRIVVER
+I: -
+O: DriverVer_type
+
+N: CCISS_GETFIRMVER
+I: -
+O: FirmwareVer_type
+
+N: CCISS_GETHEARTBEAT
+I: -
+O: Heartbeat_type
+
+N: CCISS_GETINTINFO
+I: -
+O: cciss_coalint_struct
+
+N: CCISS_GETLUNINFO
+I: -
+O: LogvolInfo_struct
+
+N: CCISS_GETNODENAME
+I: -
+O: NodeName_type
+
+N: CCISS_GETPCIINFO
+I: -
+O: cciss_pci_info_struct
+
+N: CCISS_PASSTHRU
+I: IOCTL_Command_struct [+ IOCTL_Command_struct::buf_size]
+O: IOCTL_Command_struct [+ IOCTL_Command_struct::buf_size]
+
 CCISS_PASSTHRU32
 
 N: CCISS_REGNEWD
@@ -598,6 +692,14 @@ N: CCISS_REVALIDVOLS
 I: -
 O: -
 
+N: CCISS_SETINTINFO
+I: cciss_coalint_struct
+O: -
+
+N: CCISS_SETNODENAME
+I: NodeName_type
+O: -
+
 N: CDROMCLOSETRAY
 I: -
 O: -
@@ -986,7 +1088,10 @@ N: D7SIOCWR
 I: int
 O: -
 
-DASDAPIVER
+N: DASDAPIVER
+I: -
+O: int
+
 DECODER_DUMP
 DECODER_ENABLE_OUTPUT
 DECODER_GET_CAPABILITIES
@@ -1101,25 +1206,83 @@ DRM32_IOCTL_MAP_BUFS
 DRM32_IOCTL_RES_CTX
 DRM32_IOCTL_SET_UNIQUE
 DRM32_IOCTL_VERSION
-DRM_IOCTL_ADD_BUFS
-DRM_IOCTL_ADD_CTX
-DRM_IOCTL_ADD_DRAW
-DRM_IOCTL_AUTH_MAGIC
-DRM_IOCTL_BLOCK
-DRM_IOCTL_CONTROL
-DRM_IOCTL_FINISH
-DRM_IOCTL_GET_CTX
-DRM_IOCTL_GET_MAGIC
-DRM_IOCTL_IRQ_BUSID
-DRM_IOCTL_LOCK
-DRM_IOCTL_MARK_BUFS
-DRM_IOCTL_MOD_CTX
-DRM_IOCTL_NEW_CTX
-DRM_IOCTL_RM_CTX
-DRM_IOCTL_RM_DRAW
-DRM_IOCTL_SWITCH_CTX
-DRM_IOCTL_UNBLOCK
-DRM_IOCTL_UNLOCK
+
+N: DRM_IOCTL_ADD_BUFS
+I: struct drm_buf_desc
+O: struct drm_buf_desc
+
+N: DRM_IOCTL_ADD_CTX
+I: struct drm_ctx
+O: struct drm_ctx
+
+N: DRM_IOCTL_ADD_DRAW
+I: -
+O: struct drm_draw
+
+N: DRM_IOCTL_AUTH_MAGIC
+I: struct drm_auth
+O: -
+
+N: DRM_IOCTL_BLOCK
+I: -
+O: -
+
+N: DRM_IOCTL_CONTROL
+I: struct drm_control
+O: -
+
+N: DRM_IOCTL_FINISH
+I: -
+O: -
+
+N: DRM_IOCTL_GET_CTX
+I: struct drm_ctx
+O: struct drm_ctx
+
+N: DRM_IOCTL_GET_MAGIC
+I: -
+O: struct drm_auth
+
+N: DRM_IOCTL_IRQ_BUSID
+I: struct drm_irq_busid
+O: struct drm_irq_busid
+
+N: DRM_IOCTL_LOCK
+I: struct drm_lock
+O: -
+
+N: DRM_IOCTL_MARK_BUFS
+I: struct drm_buf_desc
+O: -
+
+N: DRM_IOCTL_MOD_CTX
+I: -
+O: -
+
+N: DRM_IOCTL_NEW_CTX
+I: struct drm_ctx
+O: -
+
+N: DRM_IOCTL_RM_CTX
+I: struct drm_ctx
+O: -
+
+N: DRM_IOCTL_RM_DRAW
+I: -
+O: -
+
+N: DRM_IOCTL_SWITCH_CTX
+I: struct drm_ctx
+O: -
+
+N: DRM_IOCTL_UNBLOCK
+I: -
+O: -
+
+N: DRM_IOCTL_UNLOCK
+I: struct drm_lock
+O: -
+
 DS_ACCESS_CONFIGURATION_REGISTER
 DS_ADJUST_RESOURCE_INFO
 DS_BIND_MTD
@@ -1181,7 +1344,10 @@ ENCODER_GET_CAPABILITIES
 ENCODER_SET_INPUT
 ENCODER_SET_NORM
 ENCODER_SET_OUTPUT
-ENI_MEMDUMP
+
+N: ENI_MEMDUMP
+I: -
+O: -
 
 N: ENI_SETMULT
 I: struct eni_multipliers
@@ -1198,7 +1364,10 @@ ENVCTRL_RD_SHUTDOWN_TEMPERATURE
 ENVCTRL_RD_VOLTAGE_STATUS
 ENVCTRL_RD_WARNING_TEMPERATURE
 EVIOCGABS(abs)
-EVIOCGEFFECTS
+
+N: EVIOCGEFFECTS
+I: -
+O: int
 
 N: EVIOCGID
 I: -
@@ -1240,9 +1409,17 @@ FBIOGCURMAX
 FBIOGCURPOS
 FBIOGCURSOR
 FBIOGCURSOR32
-FBIOGETCMAP
+
+N: FBIOGETCMAP
+I: struct fb_cmap_user + u16 [?] + u16 [?] + u16 [?]
+O: u16 [?]
+
 FBIOGETCMAP32
-FBIOGETCMAP_SPARC
+
+N: FBIOGETCMAP_SPARC
+I: int + int + unsigned char __user * + unsigned char __user * + unsigned char
+__user *
+O: u8 [?] + u8 [?] + u8 [?]
 
 N: FBIOGET_CON2FBMAP
 I: struct fb_con2fbmap
@@ -1273,7 +1450,10 @@ O: -
 FBIOPUTCMAP
 FBIOPUTCMAP32
 FBIOPUTCMAP_SPARC
-FBIOPUT_CON2FBMAP
+
+N: FBIOPUT_CON2FBMAP
+I: struct fb_con2fbmap
+O: -
 
 N: FBIOPUT_VSCREENINFO
 I: struct fb_var_screeninfo
@@ -1488,7 +1668,11 @@ GET_BITMAP_FILE
 GET_DISK_INFO
 GIO_FONT
 GIO_FONTX
-GIO_SCRNMAP
+
+N: GIO_SCRNMAP
+I: -
+O: unsigned char [E_TABSZ]
+
 GIO_UNIMAP
 GIO_UNISCRNMAP
 
@@ -1521,19 +1705,59 @@ I: struct hci_dev_info
 O: struct hci_dev_info
 
 HCIGETDEVLIST
-HCIINQUIRY
-HCISETACLMTU
-HCISETAUTH
-HCISETENCRYPT
-HCISETLINKMODE
-HCISETLINKPOL
-HCISETPTYPE
-HCISETRAW
-HCISETSCAN
-HCISETSCOMTU
-HCISETSECMGR
-HCIUARTGETPROTO
-HCIUARTSETPROTO
+
+N: HCIINQUIRY
+I: struct hci_inquiry_req
+O: struct hci_inquiry_req + struct inquiry_info [?]
+
+N: HCISETACLMTU
+I: struct hci_dev_req
+O: -
+
+N: HCISETAUTH
+I: struct hci_dev_req
+O: -
+
+N: HCISETENCRYPT
+I: struct hci_dev_req
+O: -
+
+N: HCISETLINKMODE
+I: struct hci_dev_req
+O: -
+
+N: HCISETLINKPOL
+I: struct hci_dev_req
+O: -
+
+N: HCISETPTYPE
+I: struct hci_dev_req
+O: -
+
+N: HCISETRAW
+I: (nusigned long) arg
+O: -
+
+N: HCISETSCAN
+I: struct hci_dev_req
+O: -
+
+N: HCISETSCOMTU
+I: struct hci_dev_req
+O: -
+
+N: HCISETSECMGR
+I: (nusigned long) arg
+O: -
+
+N: HCIUARTGETPROTO
+I: -
+O: -
+
+N: HCIUARTSETPROTO
+I: (int) arg
+O: -
+
 HDIO_DRIVE_CMD
 HDIO_DRIVE_TASK
 HDIO_GETGEO
@@ -1559,46 +1783,151 @@ N: HE_GET_REG
 I: struct he_ioctl_reg
 O: struct he_ioctl_reg
 
-HIDIOCAPPLICATION
-HIDIOCGCOLLECTIONINDEX
-HIDIOCGCOLLECTIONINFO
-HIDIOCGDEVINFO
-HIDIOCGFIELDINFO
-HIDIOCGFLAG
-HIDIOCGREPORT
-HIDIOCGREPORTINFO
+N: HIDIOCAPPLICATION
+I: (unsigned) arg
+O: -
+
+N: HIDIOCGCOLLECTIONINDEX
+I: struct hiddev_usage_ref
+O: -
+
+N: HIDIOCGCOLLECTIONINFO
+I: struct hiddev_collection_info
+O: struct hiddev_collection_info
+
+N: HIDIOCGDEVINFO
+I: -
+O: struct hiddev_devinfo
+
+N: HIDIOCGFIELDINFO
+I: -
+O: struct hiddev_field_info
+
+N: HIDIOCGFLAG
+I: -
+O: int
+
+N: HIDIOCGREPORT
+I: struct hiddev_report_info
+O -
+
+N: HIDIOCGREPORTINFO
+I: struct hiddev_report_info
+O: struct hiddev_report_info
+
 HIDIOCGSTRING
-HIDIOCGUCODE
-HIDIOCGUSAGE
-HIDIOCGUSAGES
-HIDIOCGVERSION
-HIDIOCINITREPORT
-HIDIOCSFLAG
-HIDIOCSREPORT
-HIDIOCSUSAGE
-HIDIOCSUSAGES
-HIDPCONNADD
-HIDPCONNDEL
-HIDPGETCONNINFO
-HIDPGETCONNLIST
+
+N: HIDIOCGUCODE
+I: struct hiddev_usage_ref
+O: struct hiddev_usage_ref
+
+N: HIDIOCGUSAGE
+I: struct hiddev_usage_ref
+O: struct hiddev_usage_ref
+
+N: HIDIOCGUSAGES
+I: struct hiddev_usage_ref_multi
+O: struct hiddev_usage_ref_multi
+
+N: HIDIOCGVERSION
+I: -
+O: int
+
+N: HIDIOCINITREPORT
+I: -
+O: -
+
+N: HIDIOCSFLAG
+I: int
+O: -
+
+N: HIDIOCSREPORT
+I: struct hiddev_report_info
+O: -
+
+N: HIDIOCSUSAGE
+I: struct hiddev_usage_ref
+O: -
+
+N: HIDIOCSUSAGES
+I: struct hiddev_usage_ref_multi
+O: -
+
+N: HIDPCONNADD
+I: struct hidp_connadd_req
+O: struct hidp_connadd_req
+
+N: HIDPCONNDEL
+I: struct hidp_conndel_req
+O -
+
+N: HIDPGETCONNINFO
+I: struct hidp_conninfo
+O: struct hidp_conninfo
+
+N: HIDPGETCONNLIST
+I: struct hidp_connlist_req
+O: struct hidp_connlist_req
+
 HOT_ADD_DISK
 HOT_GENERATE_ERROR
 HOT_REMOVE_DISK
-HPET_DPI
-HPET_EPI
-HPET_IE_OFF
-HPET_IE_ON
-HPET_INFO
-HPET_IRQFREQ
-I2C_FUNCS
-I2C_PEC
+
+N: HPET_DPI
+I: -
+O: -
+
+N: HPET_EPI
+I: -
+O: -
+
+N: HPET_IE_OFF
+I: -
+O: -
+
+N: HPET_IE_ON
+I: -
+O: -
+
+N: HPET_INFO
+I: -
+O: struct hpet_info
+
+N: HPET_IRQFREQ
+I: (unsigned long) arg
+O: -
+
+N: I2C_FUNCS
+I: -
+O: unsigned long
+
+N: I2C_PEC
+I: (unsigned long) arg
+O: -
+
 I2C_RDWR
-I2C_RETRIES
-I2C_SLAVE
-I2C_SLAVE_FORCE
+
+N: I2C_RETRIES
+I: (int) arg
+O: -
+
+N: I2C_SLAVE
+I: (int) arg
+O: -
+
+N: I2C_SLAVE_FORCE
+I: (int) arg
+O: -
+
 I2C_SMBUS
-I2C_TENBIT
-I2C_TIMEOUT
+
+N: I2C_TENBIT
+I: (unsigned long) arg
+O: -
+
+N: I2C_TIMEOUT
+I: (int) arg
+O: -
 
 N: I2OEVTGET
 I: -
@@ -1619,40 +1948,77 @@ I2OPARMGET
 I2OPARMSET
 I2OPASSTHRU
 I2OPASSTHRU32
-I2ORESCANCMD
-I2ORESETCMD
-I2OSWDEL
+
+N: I2ORESCANCMD
+I: -
+O: -
+
+N: I2ORESETCMD
+I: -
+O: -
+
+N: I2OSWDEL
+I: struct i2o_sw_xfer + unsigned int
+O: -
+
 I2OSWDL
 I2OSWUL
 I2OUSRCMD
-I2OVALIDATE
-I8K_BIOS_VERSION
-I8K_FN_STATUS
-I8K_GET_FAN
-I8K_GET_SPEED
-I8K_GET_TEMP
-I8K_MACHINE_ID
-I8K_POWER_STATUS
-I8K_SET_FAN
 
-N: IDT77105_GETSTAT
+N: I2OVALIDATE
+I: (int) arg
+O: -
+
+N: I8K_BIOS_VERSION
 I: -
-O: struct idt77105_stats
+O: int
 
-N: IDT77105_GETSTATZ
+N: I8K_FN_STATUS
 I: -
-O: struct idt77105_stats
+O: int
 
-IIOCDBGVAR
-IIOCDELRULE
-IIOCDOCFACT
-IIOCDOCFDIS
-IIOCDOCFINT
-IIOCDODFACT
-IIOCDRVCTL
-IIOCGETCPS
-IIOCGETDRV
-IIOCGETDVR
+N: I8K_GET_FAN
+I: int
+O: int
+
+N: I8K_GET_SPEED
+I: int
+O: int
+
+N: I8K_GET_TEMP
+I: -
+O: int
+
+N: I8K_MACHINE_ID
+I: -
+O: unsigned char [16]
+
+N: I8K_POWER_STATUS
+I: -
+O: int
+
+N: I8K_SET_FAN
+I: int + int
+O: int
+
+N: IDT77105_GETSTAT
+I: -
+O: struct idt77105_stats
+
+N: IDT77105_GETSTATZ
+I: -
+O: struct idt77105_stats
+
+IIOCDBGVAR
+IIOCDELRULE
+IIOCDOCFACT
+IIOCDOCFDIS
+IIOCDOCFINT
+IIOCDODFACT
+IIOCDRVCTL
+IIOCGETCPS
+IIOCGETDRV
+IIOCGETDVR
 IIOCGETMAP
 IIOCGETNAM
 IIOCGETPRF
@@ -1714,8 +2080,14 @@ IOCTL_TIUSB_GET_MAXPS
 IOCTL_TIUSB_RESET_DEVICE
 IOCTL_TIUSB_RESET_PIPES
 IOCTL_TIUSB_TIMEOUT
-IOC_NVRAM_GET_OFFSET
-IOC_NVRAM_SYNC
+
+N: IOC_NVRAM_GET_OFFSET
+I: int
+O: int
+
+N: IOC_NVRAM_SYNC
+I: -
+O: -
 
 N: IRTTY_IOCGET
 I: -
@@ -1725,48 +2097,167 @@ N: IRTTY_IOCTDONGLE
 I: (IRDA_DONGLE) arg
 O: -
 
-IXJCTL_AEC_GET_LEVEL
-IXJCTL_AEC_START
-IXJCTL_AEC_STOP
-IXJCTL_CARDTYPE
-IXJCTL_CID
-IXJCTL_CIDCW
-IXJCTL_DAA_AGAIN
-IXJCTL_DAA_COEFF_SET
-IXJCTL_DRYBUFFER_CLEAR
-IXJCTL_DRYBUFFER_READ
-IXJCTL_DSP_IDLE
+N: IXJCTL_AEC_GET_LEVEL
+I: -
+O: -
+
+N: IXJCTL_AEC_START
+I: (int) arg
+O: -
+
+N: IXJCTL_AEC_STOP
+I: -
+O: -
+
+N: IXJCTL_CARDTYPE
+I: -
+O: -
+
+N: IXJCTL_CID
+I: -
+O: PHONE_CID
+
+N: IXJCTL_CIDCW
+I: PHONE_CID
+O: -
+
+N: IXJCTL_DAA_AGAIN
+I: (char) arg
+O: -
+
+N: IXJCTL_DAA_COEFF_SET
+I: (unsigned long) arg
+O: -
+
+N: IXJCTL_DRYBUFFER_CLEAR
+I: -
+O: -
+
+N: IXJCTL_DRYBUFFER_READ
+I: -
+O: unsigned long
+
+N: IXJCTL_DSP_IDLE
+I: -
+O: -
+
 IXJCTL_DSP_RESET
-IXJCTL_DSP_TYPE
-IXJCTL_DSP_VERSION
-IXJCTL_DTMF_PRESCALE
-IXJCTL_FILTER_CADENCE
-IXJCTL_FRAMES_READ
-IXJCTL_FRAMES_WRITTEN
-IXJCTL_GET_FILTER_HIST
-IXJCTL_HZ
-IXJCTL_INIT_TONE
-IXJCTL_INTERCOM_START
-IXJCTL_INTERCOM_STOP
-IXJCTL_MIXER
+
+N: IXJCTL_DSP_TYPE
+I: -
+O: -
+
+N: IXJCTL_DSP_VERSION
+I: -
+O: -
+
+N: IXJCTL_DTMF_PRESCALE
+I: (int) arg
+O: -
+
+N: IXJCTL_FILTER_CADENCE
+I: IXJ_FILTER_CADENCE
+O: -
+
+N: IXJCTL_FRAMES_READ
+I: -
+O: unsigned long
+
+N: IXJCTL_FRAMES_WRITTEN
+I: -
+O: unsigned long
+
+N: IXJCTL_GET_FILTER_HIST
+I: (unsigned long) arg
+O: -
+
+N: IXJCTL_HZ
+I: (int) arg
+O: -
+
+N: IXJCTL_INIT_TONE
+I: IXJ_TONE
+O: -
+
+N: IXJCTL_INTERCOM_START
+I: (int) arg
+O: -
+
+N: IXJCTL_INTERCOM_STOP
+I: (int) arg
+O: -
+
+N: IXJCTL_MIXER
+I: (long) arg
+O: -
+
 IXJCTL_PLAY_CID
-IXJCTL_PORT
-IXJCTL_POTS_PSTN
-IXJCTL_PSTN_LINETEST
-IXJCTL_RATE
-IXJCTL_READ_WAIT
-IXJCTL_SC_RXG
-IXJCTL_SC_TXG
-IXJCTL_SERIAL
-IXJCTL_SET_FILTER
-IXJCTL_SET_FILTER_RAW
-IXJCTL_SET_LED
-IXJCTL_SIGCTL
-IXJCTL_TESTRAM
+
+N: IXJCTL_PORT
+I: (int) arg
+O: -
+
+N: IXJCTL_POTS_PSTN
+I: (int) arg
+O: -
+
+N: IXJCTL_PSTN_LINETEST
+I: -
+O: -
+
+N: IXJCTL_RATE
+I: (int) arg
+O: -
+
+N: IXJCTL_READ_WAIT
+I: -
+O: unsigned long
+
+N: IXJCTL_SC_RXG
+I: (int) arg
+O: -
+
+N: IXJCTL_SC_TXG
+I: (int) arg
+O: -
+
+N: IXJCTL_SERIAL
+I: -
+O: -
+
+N: IXJCTL_SET_FILTER
+I: IXJ_FILTER
+O: -
+
+N: IXJCTL_SET_FILTER_RAW
+I: IXJ_FILTER_RAW
+O: -
+
+N: IXJCTL_SET_LED
+I: (int) arg
+O: -
+
+N: IXJCTL_SIGCTL
+I: IXJ_SIGDEF
+O: -
+
+N: IXJCTL_TESTRAM
+I: -
+O: -
+
 IXJCTL_TONE_CADENCE
-IXJCTL_VERSION
-IXJCTL_VMWI
-IXJCTL_WRITE_WAIT
+
+N: IXJCTL_VERSION
+I: -
+O: "\nDriver version IXJ_VER_MAJOR.IXJ_VER_MINOR.IXJ_BLD_VER"
+
+N: IXJCTL_VMWI
+I: (int) arg
+O: -
+
+N: IXJCTL_WRITE_WAIT
+I: -
+O: unsigned long
 
 N: JFFS_GET_STATUS
 I: -
@@ -1780,39 +2271,120 @@ N: JFFS_PRINT_TREE
 I: -
 O: -
 
-JSIOCGAXES
-JSIOCGAXMAP
-JSIOCGBTNMAP
-JSIOCGBUTTONS
+N: JSIOCGAXES
+I: -
+O: __u8
+
+N: JSIOCGAXMAP
+I: -
+O: __u8 [ABS_MAX + 1]
+
+N: JSIOCGBTNMAP
+I: -
+O: __u16 [KEY_MAX - BTN_MISC + 1]
+
+N: JSIOCGBUTTONS
+I: -
+O: __u8
+
 JSIOCGCORR
-JSIOCGVERSION
-JSIOCSAXMAP
-JSIOCSBTNMAP
+
+N: JSIOCGVERSION
+I: -
+O: __u32
+
+N: JSIOCSAXMAP
+I: __u8 [ABS_MAX + 1]
+O: -
+
+N: JSIOCSBTNMAP
+I: __u16 [KEY_MAX - BTN_MISC + 1]
+O: -
+
 JSIOCSCORR
 KDFONTOP
-KDGETKEYCODE
-KDGETLED
-KDGETMODE
+
+N: KDGETKEYCODE
+I: struct kbkeycode
+O: unsigned int
+
+N: KDGETLED
+I: -
+O: unsigned char
+
+N: KDGETMODE
+I: -
+O: unsigned char
+
 KDGHWCLK
 KDGKBDIACR
-KDGKBENT
-KDGKBLED
-KDGKBMETA
-KDGKBMODE
+
+N: KDGKBENT
+I: struct kbentry
+O: unsigned short
+
+N: KDGKBLED
+I: -
+O: unsigned char
+
+N: KDGKBMETA
+I: -
+O: unsigned char
+
+N: KDGKBMODE
+I: -
+O: unsigned char
+
 KDGKBSENT
-KDGKBTYPE
-KDKBDREP
-KDMKTONE
-KDSETKEYCODE
-KDSETLED
-KDSETMODE
+
+N: KDGKBTYPE
+I: -
+O: unsigned char
+
+N: KDKBDREP
+I: struct kbd_repeat
+O: struct kbd_repeat
+
+N: KDMKTONE
+I: (unsigned int) arg
+O: -
+
+N: KDSETKEYCODE
+I: struct kbkeycode
+O: -
+
+N: KDSETLED
+I: (unsigned int) arg
+O: -
+
+N: KDSETMODE
+I: (unsigned char) arg
+O: -
+
 KDSHWCLK
-KDSIGACCEPT
+
+N: KDSIGACCEPT
+I: (int) arg
+O: -
+
 KDSKBDIACR
-KDSKBENT
-KDSKBLED
-KDSKBMETA
-KDSKBMODE
+
+N: KDSKBENT
+I: struct kbentry
+O: -
+
+N: KDSKBLED
+I: (unsigned char) arg
+O: -
+
+N: KDSKBMETA
+I: (unsigned char) arg
+O: -
+
+N: KDSKBMODE
+I: (unsigned char) arg
+O: -
+
 KDSKBSENT
 KIOCCMD
 KIOCGLED
@@ -1821,16 +2393,39 @@ KIOCGTRANS
 KIOCLAYOUT
 KIOCSDIRECT
 KIOCSLED
-KIOCSOUND
+
+N: KIOCSOUND
+I: (unsigned int) arg
+O: -
+
 KIOCSRATE
 KIOCTRANS
 KIOCTYPE
-KYRO_IOCTL_OVERLAY_CREATE
-KYRO_IOCTL_OVERLAY_OFFSET
-KYRO_IOCTL_OVERLAY_VIEWPORT_SET
-KYRO_IOCTL_SET_VIDEO_MODE
-KYRO_IOCTL_STRIDE
-KYRO_IOCTL_UVSTRIDE
+
+N: KYRO_IOCTL_OVERLAY_CREATE
+I: overlay_create
+O: -
+
+N: KYRO_IOCTL_OVERLAY_OFFSET
+I: -
+O: unsigned long
+
+N: KYRO_IOCTL_OVERLAY_VIEWPORT_SET
+I: overlay_viewport_set
+O: -
+
+N: KYRO_IOCTL_SET_VIDEO_MODE
+I: -
+O: -
+
+N: KYRO_IOCTL_STRIDE
+I: -
+O: unsigned long
+
+N: KYRO_IOCTL_UVSTRIDE
+I: -
+O: unsigned long
+
 LEO_CLUTALLOC
 LEO_CLUTFREE
 LEO_CLUTPOST
@@ -1894,23 +2489,70 @@ N: MATROXFB_SET_OUTPUT_MODE
 I: struct matroxioc_output_mode
 O: -
 
-MCE_GETCLEAR_FLAGS
-MCE_GET_LOG_LEN
-MCE_GET_RECORD_LEN
+N: MCE_GETCLEAR_FLAGS
+I: -
+O: unsigned
+
+N: MCE_GET_LOG_LEN
+I: -
+O: int
+
+N: MCE_GET_RECORD_LEN
+I: -
+O: int
+
 MEGAIOCCMD
-MEMERASE
-MEMGETBADBLOCK
-MEMGETINFO
-MEMGETOOBSEL
-MEMGETREGIONCOUNT
-MEMGETREGIONINFO
-MEMLOCK
-MEMREADOOB
+
+N: MEMERASE
+I: struct erase_info_user
+O: -
+
+N: MEMGETBADBLOCK
+I: loff_t
+O: -
+
+N: MEMGETINFO
+I: -
+O: struct mtd_info_user
+
+N: MEMGETOOBSEL
+I: -
+O: struct nand_oobinfo
+
+N: MEMGETREGIONCOUNT
+I: -
+O: int
+
+N: MEMGETREGIONINFO
+I: struct region_info_user
+O: struct mtd_erase_region_info
+
+N: MEMLOCK
+I: struct erase_info_user
+O: -
+
+N: MEMREADOOB
+I: struct mtd_oob_buf
+O: uint32_t retlen + unsigned char [retlen]
+
 MEMREADOOB32
-MEMSETBADBLOCK
-MEMSETOOBSEL
-MEMUNLOCK
-MEMWRITEOOB
+
+N: MEMSETBADBLOCK
+I: loff_t
+O: -
+
+N: MEMSETOOBSEL
+I: struct nand_oobinfo
+O: -
+
+N: MEMUNLOCK
+I: struct erase_info_user
+O: -
+
+N: MEMWRITEOOB
+I: struct mtd_oob_buf + unsigned char [struct mtd_oob_buf::length]
+O: uint32_t
+
 MEMWRITEOOB32
 MEYEIOC_G_PARAMS
 MEYEIOC_QBUF_CAPT
@@ -1918,20 +2560,61 @@ MEYEIOC_STILLCAPT
 MEYEIOC_STILLJCAPT
 MEYEIOC_SYNC
 MEYEIOC_S_PARAMS
+
 MGSL_IOCCLRMODCOUNT
-MGSL_IOCGIF
-MGSL_IOCGSTATS
-MGSL_IOCGTXIDLE
-MGSL_IOCLOOPTXDONE
-MGSL_IOCRXENABLE
-MGSL_IOCSIF
-MGSL_IOCSTXIDLE
-MGSL_IOCTXABORT
-MGSL_IOCTXENABLE
-MICROCODE_IOCFREE
-MMTIMER_GETBITS
-MMTIMER_GETOFFSET
-MMTIMER_MMAPAVAIL
+
+N: MGSL_IOCGIF
+I: -
+O: int
+
+N: MGSL_IOCGSTATS
+I: -
+O: struct mgsl_icount
+
+N: MGSL_IOCGTXIDLE
+I: -
+O: int
+
+N: MGSL_IOCLOOPTXDONE
+I: -
+O: -
+
+N: MGSL_IOCRXENABLE
+I: (int) arg
+O: -
+
+N: MGSL_IOCSIF
+I: (int) arg
+O: -
+
+N: MGSL_IOCSTXIDLE
+I: (int) arg
+O: -
+
+N: MGSL_IOCTXABORT
+I: -
+O: -
+
+N: MGSL_IOCTXENABLE
+I: (int) arg
+O: -
+
+N: MICROCODE_IOCFREE
+I: -
+O: -
+
+N: MMTIMER_GETBITS
+I: -
+O: -
+
+N: MMTIMER_GETOFFSET
+I: -
+O: -
+
+N: MMTIMER_MMAPAVAIL
+I: -
+O: -
+
 MPTCOMMAND
 MPTCOMMAND32
 MPTEVENTENABLE
@@ -1976,39 +2659,113 @@ MTRRIOC32_SET_ENTRY
 MTRRIOC32_SET_PAGE_ENTRY
 MXB_S_AUDIO_CD
 MXB_S_AUDIO_LINE
-NBD_CLEAR_QUE
-NBD_CLEAR_SOCK
-NBD_DISCONNECT
-NBD_DO_IT
-NBD_PRINT_DEBUG
-NBD_SET_BLKSIZE
-NBD_SET_SIZE
-NBD_SET_SIZE_BLOCKS
-NBD_SET_SOCK
-NCP_IOC_CONN_LOGGED_IN
-NCP_IOC_GETCHARSETS
-NCP_IOC_GETDENTRYTTL
+
+N: NBD_CLEAR_QUE
+I: -
+O: -
+
+N: NBD_CLEAR_SOCK
+I: -
+O: -
+
+N: NBD_DISCONNECT
+I: -
+O: -
+
+N: NBD_DO_IT
+I: -
+O: -
+
+N: NBD_PRINT_DEBUG
+I: -
+O: -
+
+N: NBD_SET_BLKSIZE
+I: (int) arg
+O: -
+
+N: NBD_SET_SIZE
+I: (u64) arg
+O: -
+
+N: NBD_SET_SIZE_BLOCKS
+I: (u64) arg
+O: -
+
+N: NBD_SET_SOCK
+I: (unsigned int) arg
+O: -
+
+N: NCP_IOC_CONN_LOGGED_IN
+I: -
+O: -
+
+N: NCP_IOC_GETCHARSETS
+I: -
+O: struct ncp_nls_ioctl
+
+N: NCP_IOC_GETDENTRYTTL
+I: -
+O: u_int32_t
+
 NCP_IOC_GETMOUNTUID2_32
 NCP_IOC_GETOBJECTNAME_32
 NCP_IOC_GETPRIVATEDATA_32
-NCP_IOC_GETROOT
+
+N: NCP_IOC_GETROOT
+I: -
+O: struct ncp_setroot_ioctl
+
 NCP_IOC_GET_FS_INFO_V2_32
-NCP_IOC_LOCKUNLOCK
+
+N: NCP_IOC_LOCKUNLOCK
+I: struct ncp_lock_ioctl
+O: -
+
 NCP_IOC_NCPREQUEST_32
-NCP_IOC_SETCHARSETS
-NCP_IOC_SETDENTRYTTL
+
+N: NCP_IOC_SETCHARSETS
+I: struct ncp_nls_ioctl
+O: -
+
+N: NCP_IOC_SETDENTRYTTL
+I: u_int32_t
+O: -
+
 NCP_IOC_SETOBJECTNAME_32
 NCP_IOC_SETPRIVATEDATA_32
-NCP_IOC_SETROOT
-NCP_IOC_SET_SIGN_WANTED
-NCP_IOC_SIGN_INIT
-NCP_IOC_SIGN_WANTED
+
+N: NCP_IOC_SETROOT
+I: struct ncp_setroot_ioctl
+O: -
+
+N: NCP_IOC_SET_SIGN_WANTED
+I: unsigned char
+O: -
+
+N: NCP_IOC_SIGN_INIT
+I: [struct ncp_sign_init]
+O: -
+
+N: NCP_IOC_SIGN_WANTED
+I: -
+O: int
+
 NET_ADD_IF
 NET_GET_IF
 NET_REMOVE_IF
-NS_ADJBUFLEV
-NS_GETPSTAT
-NS_SETBUFLEV
+
+N: NS_ADJBUFLEV
+I: (int) arg
+O: -
+
+N: NS_GETPSTAT
+I: int
+O: pool_levels
+
+N: NS_SETBUFLEV
+I: pool_levels
+O: -
 
 N: NVRAM_INIT
 I: -
@@ -2018,11 +2775,24 @@ N: NVRAM_SETCKS
 I: -
 O: -
 
-OLD_PHONE_RING_START
+N: OLD_PHONE_RING_START
+I: -
+O: -
+
 OPIOCGET
-OPIOCGETCHILD
-OPIOCGETNEXT
-OPIOCGETOPTNODE
+
+N: OPIOCGETCHILD
+I: int
+O: int
+
+N: OPIOCGETNEXT
+I: int
+O: int
+
+N: OPIOCGETOPTNODE
+I: -
+O: int
+
 OPIOCNEXTPROP
 OPIOCSET
 OPROMCHILD
@@ -2042,11 +2812,25 @@ OPROMSETOPT2
 OPROMU2P
 OSD_GET_CAPABILITY
 OSD_SEND_CMD
-OSS_GETVERSION
-OTPGETREGIONCOUNT
+
+N: OSS_GETVERSION
+I: -
+O: int
+
+N: OTPGETREGIONCOUNT
+I: -
+O: int
+
 OTPGETREGIONINFO
-OTPLOCK
-OTPSELECT
+
+N: OTPLOCK
+I: struct otp_info
+O: -
+
+N: OTPSELECT
+I: int
+O: -
+
 OV511IOC_RI2C
 OV511IOC_WI2C
 OVCAMCHIP_CMD_G_CTRL
@@ -2055,76 +2839,281 @@ OVCAMCHIP_CMD_Q_SUBTYPE
 OVCAMCHIP_CMD_S_CTRL
 OVCAMCHIP_CMD_S_MODE
 OVCAMCHIP_MAX_CMD
-PACKET_CTRL_CMD
-PA_PERF_OFF
-PA_PERF_ON
-PA_PERF_VERSION
-PCIIOC_CONTROLLER
-PCIIOC_MMAP_IS_IO
-PCIIOC_MMAP_IS_MEM
-PCIIOC_WRITE_COMBINE
-PHONE_BUSY
-PHONE_CAPABILITIES
-PHONE_CAPABILITIES_CHECK
+
+N: PACKET_CTRL_CMD
+I: struct pkt_ctrl_command
+O: struct pkt_ctrl_command
+
+N: PA_PERF_OFF
+I: -
+O: uint32_t [4]
+
+N: PA_PERF_ON
+I: -
+O: -
+
+N: PA_PERF_VERSION
+I: -
+O: int
+
+N: PCIIOC_CONTROLLER
+I: -
+O: -
+
+N: PCIIOC_MMAP_IS_IO
+I: -
+O: -
+
+N: PCIIOC_MMAP_IS_MEM
+I: -
+O: -
+
+N: PCIIOC_WRITE_COMBINE
+I: (unsigned long) arg
+O: -
+
+N: PHONE_BUSY
+I: -
+O: -
+
+N: PHONE_CAPABILITIES
+I: -
+O: -
+
+N: PHONE_CAPABILITIES_CHECK
+I: struct phone_capability
+O: -
+
 PHONE_CAPABILITIES_LIST
-PHONE_CPT_STOP
-PHONE_DIALTONE
-PHONE_DTMF_OOB
-PHONE_DTMF_READY
-PHONE_EXCEPTION
-PHONE_FRAME
-PHONE_GET_DTMF
-PHONE_GET_DTMF_ASCII
-PHONE_GET_TONE_OFF_TIME
-PHONE_GET_TONE_ON_TIME
-PHONE_GET_TONE_STATE
-PHONE_HOOKSTATE
-PHONE_MAXRINGS
-PHONE_PLAY_CODEC
-PHONE_PLAY_DEPTH
-PHONE_PLAY_LEVEL
-PHONE_PLAY_START
-PHONE_PLAY_STOP
-PHONE_PLAY_TONE
+
+N: PHONE_CPT_STOP
+I: -
+O: -
+
+N: PHONE_DIALTONE
+I: -
+O: -
+
+N: PHONE_DTMF_OOB
+I: (unsigned int) arg
+O: -
+
+N: PHONE_DTMF_READY
+I: -
+O: -
+
+N: PHONE_EXCEPTION
+I: -
+O: -
+
+N: PHONE_FRAME
+I: (int) arg
+O: -
+
+N: PHONE_GET_DTMF
+I: -
+O: -
+
+N: PHONE_GET_DTMF_ASCII
+I: -
+O: -
+
+N: PHONE_GET_TONE_OFF_TIME
+I: -
+O: -
+
+N: PHONE_GET_TONE_ON_TIME
+I: -
+O: -
+
+N: PHONE_GET_TONE_STATE
+I: -
+O: -
+
+N: PHONE_HOOKSTATE
+I: -
+O: -
+
+N: PHONE_MAXRINGS
+I: (char) arg
+O: -
+
+N: PHONE_PLAY_CODEC
+I: (int) arg
+O: -
+
+N: PHONE_PLAY_DEPTH
+I: (int) arg
+O: -
+
+N: PHONE_PLAY_LEVEL
+I: -
+O: -
+
+N: PHONE_PLAY_START
+I: -
+O: -
+
+N: PHONE_PLAY_STOP
+I: -
+O: -
+
+N: PHONE_PLAY_TONE
+I: (char) arg
+O: -
+
 PHONE_PLAY_VOLUME
 PHONE_PLAY_VOLUME_LINEAR
-PHONE_PSTN_GET_STATE
+
+N: PHONE_PSTN_GET_STATE
+I: -
+O: -
+
 PHONE_PSTN_LINETEST
-PHONE_PSTN_SET_STATE
-PHONE_QUERY_CODEC
-PHONE_REC_CODEC
-PHONE_REC_DEPTH
-PHONE_REC_LEVEL
-PHONE_REC_START
-PHONE_REC_STOP
+
+N: PHONE_PSTN_SET_STATE
+I: (int) arg
+O: -
+
+N: PHONE_QUERY_CODEC
+I: struct phone_codec_data
+O: struct phone_codec_data
+
+N: PHONE_REC_CODEC
+I: (int) arg
+O: -
+
+N: PHONE_REC_DEPTH
+I: (int) arg
+O: -
+
+N: PHONE_REC_LEVEL
+I: -
+O: -
+
+N: PHONE_REC_START
+I: -
+O: -
+
+N: PHONE_REC_STOP
+I: -
+O: -
+
 PHONE_REC_VOLUME
 PHONE_REC_VOLUME_LINEAR
-PHONE_RING
-PHONE_RINGBACK
-PHONE_RING_CADENCE
-PHONE_RING_START
-PHONE_RING_STOP
-PHONE_SET_TONE_OFF_TIME
-PHONE_SET_TONE_ON_TIME
-PHONE_VAD
-PHONE_WINK
+
+N: PHONE_RING
+I: -
+O: -
+
+N: PHONE_RINGBACK
+I: -
+O: -
+
+N: PHONE_RING_CADENCE
+I: (unsigned short) arg
+O: -
+
+N: PHONE_RING_START
+I: [PHONE_CID]
+O: -
+
+N: PHONE_RING_STOP
+I: -
+O: -
+
+N: PHONE_SET_TONE_OFF_TIME
+I: (unsigned short) arg
+O: -
+
+N: PHONE_SET_TONE_ON_TIME
+I: (unsigned short) arg
+O: -
+
+N: PHONE_VAD
+I: (int) arg
+O: -
+
+N: PHONE_WINK
+I: -
+O: -
+
 PHONE_WINK_DURATION
 PIO_FONT
 PIO_FONTRESET
 PIO_FONTX
-PIO_SCRNMAP
+
+N: PIO_SCRNMAP
+I: unsigned char [E_TABSZ]
+O: -
+
 PIO_UNIMAP
-PIO_UNIMAPCLR
-PIO_UNISCRNMAP
-PLANBG_GRAB_BPL
-PLANBIOCGMODE
-PLANBIOCGSAAREGS
-PLANBIOCGSTAT
-PLANBIOCSMODE
-PLANBIOCSSAAREGS
+
+N: PIO_UNIMAPCLR
+I: struct unimapinit
+O: -
+
+N: PIO_UNISCRNMAP
+I: unsigned short [E_TABSZ]
+O: -
+
+N: PLANBG_GRAB_BPL
+I: -
+O: int
+
+N: PLANBIOCGMODE
+I: -
+O: int
+
+N: PLANBIOCGSAAREGS
+I: struct planb_saa_regs
+O: struct planb_saa_regs
+
+N: PLANBIOCGSTAT
+I:
+O: struct planb_stat_regs
+
+N: PLANBIOCSMODE
+I: int
+O: -
+
+N: PLANBIOCSSAAREGS
+I: struct planb_saa_regs
+O: -
+
 PLANB_INTR_DEBUG
-PLANB_INV_REGS
-PMU_IOC_SLEEP
+
+N: PLANB_INV_REGS
+I: struct planb_any_regs
+O: struct planb_any_regs
+
+N: PMU_IOC_CAN_SLEEP
+I: -
+O: __u32
+
+N: PMU_IOC_GET_BACKLIGHT
+I: -
+O: int
+
+N: PMU_IOC_GET_MODEL
+I: -
+O: int
+
+N: PMU_IOC_GRAB_BACKLIGHT
+I: -
+O: -
+
+N: PMU_IOC_HAS_ADB
+I: -
+O: int
+
+N: PMU_IOC_SET_BACKLIGHT
+I: __u32
+O: -
+
+N: PMU_IOC_SLEEP
+I: -
+O: -
 
 N: PPCLAIM
 I: -
@@ -2266,17 +3255,47 @@ N: PPPIOCSASYNCMAP
 I: u32
 O: -
 
-PPPIOCSCOMPRESS
+N: PPPIOCSCOMPRESS
+I: struct isdn_ppp_comp_data
+O: -
+
 PPPIOCSCOMPRESS32
-PPPIOCSCOMPRESSOR
-PPPIOCSDEBUG
-PPPIOCSFLAGS
-PPPIOCSMAXCID
-PPPIOCSMPFLAGS
-PPPIOCSMPMRU
-PPPIOCSMPMTU
-PPPIOCSMRRU
-PPPIOCSMRU
+
+N: PPPIOCSCOMPRESSOR
+I: struct isdn_ppp_comp_data
+O: -
+
+N: PPPIOCSDEBUG
+I: unsigned long
+O: -
+
+N: PPPIOCSFLAGS
+I: unsigned long
+O: -
+
+N: PPPIOCSMAXCID
+I: unsigned long
+O: -
+
+N: PPPIOCSMPFLAGS
+I: unsigned long
+O: -
+
+N: PPPIOCSMPMRU
+I: -
+O: -
+
+N: PPPIOCSMPMTU
+I: -
+O: -
+
+N: PPPIOCSMRRU
+I: int
+O: -
+
+N: PPPIOCSMRU
+I: int
+O: -
 
 N: PPPIOCSNPMODE
 I: struct npioctl

