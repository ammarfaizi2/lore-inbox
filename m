Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVLOIRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVLOIRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbVLOIRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:17:13 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:36214 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161002AbVLOIRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:17:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=LcV82Tu737G+dNMwwiDMN1wlPOtL3QK7OEZzySKRvjzbGeb7SG/yz4p1Mo6u0WPTqZPfdi8vfOpsByVYz+/dE0w9TqYjW6OfUjVoKVSKasH0yuxSbNwOvDgv5vHJoGv3nimLYA2j5YdWy/JI3OENqNJYRhmWbTvyUHACdqzYPAs=
Date: Thu, 15 Dec 2005 11:32:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Documentation/ioctl-mess.txt: document 85 more ioctls
Message-ID: <20051215083237.GA8471@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk removed TIOCGDEV.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/ioctl-mess.txt |  435 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 350 insertions(+), 85 deletions(-)

--- a/Documentation/ioctl-mess.txt
+++ b/Documentation/ioctl-mess.txt
@@ -3385,27 +3385,70 @@ N: RAID_VERSION
 I: -
 O: struct mdu_version_s
 
-RAW_GETBIND
-RAW_SETBIND
+N: RAW_GETBIND
+I: struct raw_config_request
+O: struct raw_config_request
+
+N: RAW_SETBIND
+I: struct raw_config_request
+O: -
+
 REISERFS_IOC_UNPACK32
-RESTART_ARRAY_RW
-RFCOMMCREATEDEV
-RFCOMMGETDEVINFO
-RFCOMMGETDEVLIST
-RFCOMMRELEASEDEV
+
+N: RESTART_ARRAY_RW
+I: -
+O: -
+
+N: RFCOMMCREATEDEV
+I: struct rfcomm_dev_req
+O: -
+
+N: RFCOMMGETDEVINFO
+I: struct rfcomm_dev_info
+O: struct rfcomm_dev_info
+
+N: RFCOMMGETDEVLIST
+I: u16
+O: struct rfcomm_dev_list_req + struct rfcomm_dev_info [?]
+
+N: RFCOMMRELEASEDEV
+I: struct rfcomm_dev_req
+O: -
+
 RFCOMMSTEALDLC
+
 RNDADDENTROPY
-RNDADDTOENTCNT
-RNDCLEARPOOL
-RNDGETENTCNT
+
+N: RNDADDTOENTCNT
+I: int
+O: -
+
+N: RNDCLEARPOOL
+I: -
+O: -
+
+N: RNDGETENTCNT
+I: -
+O: int
+
 RNDGETPOOL
-RNDZAPENTCNT
+
+N: RNDZAPENTCNT
+I: -
+O: -
+
 RTC32_EPOCH_READ
 RTC32_EPOCH_SET
 RTC32_IRQP_READ
 RTC32_IRQP_SET
-RTCGET
-RTCSET
+
+N: RTCGET
+I: -
+O: struct rtc_time
+
+N: RTCSET
+I: struct rtc_time
+O: -
 
 N: RTC_AIE_OFF
 I: -
@@ -3553,65 +3596,234 @@ N: SCSI_IOCTL_TEST_UNIT_READY
 I: -
 O: -
 
-SET_ARRAY_INFO
-SET_BITMAP_FILE
-SET_DISK_FAULTY
+N: SET_ARRAY_INFO
+I: - | mdu_array_info_t
+O: -
+
+N: SET_BITMAP_FILE
+I: (int) arg
+O: -
+
+N: SET_DISK_FAULTY
+I: (u32) arg
+O: -
+
 SET_DISK_INFO
-SG_EMULATED_HOST
-SG_GET_COMMAND_Q
-SG_GET_KEEP_ORPHAN
-SG_GET_LOW_DMA
-SG_GET_NUM_WAITING
-SG_GET_PACK_ID
-SG_GET_REQUEST_TABLE
-SG_GET_RESERVED_SIZE
-SG_GET_SCSI_ID
-SG_GET_SG_TABLESIZE
-SG_GET_TIMEOUT
-SG_GET_TRANSFORM
-SG_GET_VERSION_NUM
+
+N: SG_EMULATED_HOST
+I: -
+O: int
+
+N: SG_GET_COMMAND_Q
+I: -
+O: int
+
+N: SG_GET_KEEP_ORPHAN
+I: -
+O: int
+
+N: SG_GET_LOW_DMA
+I: -
+O: int
+
+N: SG_GET_NUM_WAITING
+I: -
+O: int
+
+N: SG_GET_PACK_ID
+I: -
+O: int
+
+N: SG_GET_REQUEST_TABLE
+I: -
+O: struct sg_req_info [SG_MAX_QUEUE]
+
+N: SG_GET_RESERVED_SIZE
+I: -
+O: int
+
+N: SG_GET_SCSI_ID
+I: -
+O: int + int + int + int + int + short + short + int [2] /* struct sg_scsi_id */
+
+N: SG_GET_SG_TABLESIZE
+I: -
+O: int
+
+N: SG_GET_TIMEOUT
+I: -
+O: -
+
+N: SG_GET_TRANSFORM
+I: -
+O: int
+
+N: SG_GET_VERSION_NUM
+I: -
+O: int
+
 SG_IO
-SG_NEXT_CMD_LEN
-SG_SCSI_RESET
-SG_SET_COMMAND_Q
-SG_SET_DEBUG
-SG_SET_FORCE_LOW_DMA
-SG_SET_FORCE_PACK_ID
-SG_SET_KEEP_ORPHAN
-SG_SET_RESERVED_SIZE
-SG_SET_TIMEOUT
-SG_SET_TRANSFORM
-SIOCADDDLCI
-SIOCADDMULTI
-SIOCADDRT
-SIOCATALKDIFADDR
-SIOCATMARK
-SIOCBONDCHANGEACTIVE
-SIOCBONDENSLAVE
-SIOCBONDINFOQUERY
-SIOCBONDRELEASE
-SIOCBONDSETHWADDR
-SIOCBONDSLAVEINFOQUERY
-SIOCBRADDBR
-SIOCBRADDIF
-SIOCBRDELBR
-SIOCBRDELIF
-SIOCDARP
-SIOCDELDLCI
-SIOCDELMULTI
-SIOCDELRT
-SIOCDIFADDR
+
+N: SG_NEXT_CMD_LEN
+I: int
+O: -
+
+N: SG_SCSI_RESET
+I: int
+O: -
+
+N: SG_SET_COMMAND_Q
+I: int
+O: -
+
+N: SG_SET_DEBUG
+I: int
+O: -
+
+N: SG_SET_FORCE_LOW_DMA
+I: int
+O: -
+
+N: SG_SET_FORCE_PACK_ID
+I: int
+O: -
+
+N: SG_SET_KEEP_ORPHAN
+I: int
+O: -
+
+N: SG_SET_RESERVED_SIZE
+I: int
+O: -
+
+N: SG_SET_TIMEOUT
+I: int
+O: -
+
+N: SG_SET_TRANSFORM
+I: (void *) arg
+O: -
+
+N: SIOCADDDLCI
+I: struct dlci_add
+O: struct dlci_add
+
+N: SIOCADDMULTI
+I: struct ifreq
+O: -
+
+N: SIOCADDRT
+I: struct rtentry
+O: -
+
+N: SIOCATALKDIFADDR
+I: struct ifreq
+O: struct ifreq
+
+N: SIOCATMARK
+I: -
+O: -
+
+N: SIOCBONDCHANGEACTIVE
+I: struct ifreq
+O: -
+
+N: SIOCBONDENSLAVE
+I: struct ifreq
+O: -
+
+N: SIOCBONDINFOQUERY
+I: struct ifreq
+O: -
+
+N: SIOCBONDRELEASE
+I: struct ifreq
+O: -
+
+N: SIOCBONDSETHWADDR
+I: struct ifreq
+O: -
+
+N: SIOCBONDSLAVEINFOQUERY
+I: struct ifreq
+O: -
+
+N: SIOCBRADDBR
+I: char buf[IFNAMSIZ]
+O: -
+
+N: SIOCBRADDIF
+I: struct ifreq
+O: -
+
+N: SIOCBRDELBR
+I: char buf[IFNAMSIZ]
+O: -
+
+N: SIOCBRDELIF
+I: struct ifreq
+O: -
+
+N: SIOCDARP
+I: struct arpreq
+O: -
+
+N: SIOCDELDLCI
+I: struct dlci_add
+O: -
+
+N: SIOCDELMULTI
+I: struct ifreq
+O: -
+
+N: SIOCDELRT
+I: struct rtentry
+O: -
+
+N: SIOCDIFADDR
+I: struct ifreq
+O: struct ifreq
+
 SIOCDRARP
-SIOCETHTOOL
-SIOCGARP
-SIOCGIFADDR
+
+N: SIOCETHTOOL
+I: struct ifreq
+O: struct ifreq
+
+N: SIOCGARP
+I: struct arpreq
+O: struct arpreq
+
+N: SIOCGIFADDR
+I: struct ifreq
+O: -
+
 SIOCGIFBR
-SIOCGIFBRDADDR
-SIOCGIFCONF
-SIOCGIFDSTADDR
-SIOCGIFENCAP
-SIOCGIFFLAGS
-SIOCGIFHWADDR
+
+N: SIOCGIFBRDADDR
+I: struct ifreq
+O: struct ifreq
+
+N: SIOCGIFCONF
+I: struct ifconf
+O: struct ifconf
+
+N: SIOCGIFDSTADDR
+I: struct ifreq
+O: struct ifreq
+
+N: SIOCGIFENCAP
+I: -
+O: int
+
+N: SIOCGIFFLAGS
+I: struct ifreq
+O: struct ifreq
+
+N: SIOCGIFHWADDR
+I: struct ifreq
+O: struct ifreq
+
 SIOCGIFINDEX
 SIOCGIFMAP
 SIOCGIFMEM
@@ -3697,23 +3909,77 @@ SIOCSIWTXPOW
 SIOCSMIIREG
 SIOCSPGRP
 SIOCSRARP
-SISFB_GET_AUTOMAXIMIZE
-SISFB_GET_AUTOMAXIMIZE_OLD
-SISFB_GET_INFO
-SISFB_GET_INFO_OLD
-SISFB_GET_INFO_SIZE
-SISFB_GET_TVPOSOFFSET
-SISFB_GET_VBRSTATUS
-SISFB_GET_VBRSTATUS_OLD
-SISFB_SET_AUTOMAXIMIZE
-SISFB_SET_AUTOMAXIMIZE_OLD
-SISFB_SET_LOCK
-SISFB_SET_TVPOSOFFSET
-SISUSB_COMMAND
-SISUSB_GET_CONFIG
-SISUSB_GET_CONFIG_SIZE
+
+N: SISFB_GET_AUTOMAXIMIZE
+I: -
+O: u32
+
+N: SISFB_GET_AUTOMAXIMIZE_OLD
+I: -
+O: u32
+
+N: SISFB_GET_INFO
+I: -
+O: struct sisfb_info
+
+N: SISFB_GET_INFO_OLD
+I: -
+O: struct sisfb_info
+
+N: SISFB_GET_INFO_SIZE
+I: -
+O: u32
+
+N: SISFB_GET_TVPOSOFFSET
+I: -
+O: u32
+
+N: SISFB_GET_TVPOSOFFSET
+I: -
+O: u32
+
+N: SISFB_GET_VBRSTATUS
+I: -
+O: u32
+
+N: SISFB_GET_VBRSTATUS_OLD
+I: -
+O: u32
+
+N: SISFB_SET_AUTOMAXIMIZE
+I: u32
+O: -
+
+N: SISFB_SET_AUTOMAXIMIZE_OLD
+I: u32
+O: -
+
+N: SISFB_SET_LOCK
+I: u32
+O: -
+
+N: SISFB_SET_TVPOSOFFSET
+I: u32
+O: -
+
+N: SISUSB_COMMAND
+I: struct sisusb_command
+O: -
+
+N: SISUSB_GET_CONFIG
+I: -
+O: struct sisusb_info
+
+N: SISUSB_GET_CONFIG_SIZE
+I: -
+O: u32
+
 SMB_IOC_GETMOUNTUID_32
-SMB_IOC_NEWCONN
+
+N: SMB_IOC_NEWCONN
+I: -
+O: struct smb_conn_opt
+
 SNDCTL_COPR_HALT
 SNDCTL_COPR_LOAD
 SNDCTL_COPR_RCODE
@@ -3860,7 +4126,6 @@ TEA6420_SWITCH
 TIOCCBRK
 TIOCCONS
 TIOCEXCL
-TIOCGDEV
 
 N: TIOCGETC
 I: -

