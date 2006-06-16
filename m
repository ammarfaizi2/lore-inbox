Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWFPBlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWFPBlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 21:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWFPBlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 21:41:35 -0400
Received: from wehq.winbond.com.tw ([202.39.229.15]:28038 "EHLO
	wehq.winbond.com.tw") by vger.kernel.org with ESMTP
	id S1750980AbWFPBld convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 21:41:33 -0400
thread-index: AcaQ5U8kbzwhhc/QSA6Vy6vU4sENOQ==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.326
Message-ID: <44920B22.4030507@winbond.com>
Date: Fri, 16 Jun 2006 09:36:34 +0800
From: "dezheng shen" <dzshen@winbond.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "PI14 SJIN" <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers [headers]
References: <448E875A.40805@winbond.com> 	<9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com> 	<448FC0C1.90205@winbond.com> <4491AEAC.5030606@drzeus.cx>
In-Reply-To: <4491AEAC.5030606@drzeus.cx>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 16 Jun 2006 01:36:34.0551 (UTC) FILETIME=[4D4E1070:01C690E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre:


> People are quite used to reading diffs, so it's not that much of a bothe

I made a typo last time. we should say, we are NOT submitting patches; 
instead, we are submitting original sources for Winbond 518/528/528DA 
MS/MSPRO/xD/SM/SD/MMC sources.

> 
> 
>> Can we pack our sources then send them in one large attachment?
> Uncompressed attachments, or inline inclusions, are usually preferred as
> it allows you to read the stuff in your mail application.

I think we will do the inline inclusion for it's easier for everybody to 
read.

> 
> I have one reservation with your driver though. The Linux kernel already
> has a generic SD/MMC layer. So if your hardware is a bus interface, then
> it should use that layer. There is even a driver there for your
> W83L518/9 devices. :)

   Hmm, we might take this suggestion into consideration later. Right 
now, we would like to keep our current architecture for internal 
maintenance issues. The first thing we would like to do now is 
contributing our 518/528/528DA MS/MSPRO/xD/SM/SD/MMC and smart card 
drivers into Linux kernel source tree. There are, of course, many things 
can be improved in our codes. But at least we have run stree testing on 
many platforms from Intel 32/64 AMD 32/64 and single/dual 
configurations. We would like to contribute to kernel first then we can 
still update/modify/improve them later. Is that OK?


> 
> For the other buses, a generic layer would be preferable, but as you
> would be the only user, that isn't required quite yet. I would suggest
> contacting Andrew Morton as he is the overall 2.6 maintainer.

   yes, and his email? thank you.


> PS. I have a question regarding the W83L518 hardware, but haven't been
> able to get in touch with the right people. Perhaps you have some pointers?

    anything about Winbond 518/528/528DA drivers, send email to 
dzshen@winbond.com which is ME.....

dz

ps. did  you get my email from linux-kernel? It seems like my emails to 
linux-kernel with my attachments are gone for no reason. Will that be my 
email size is over 100k?





/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
		name		<wmwu AT yyy.com>
		Shuai Jin	<jin.shuai AT gmail.com>
		Yuan Mu		<ymu AT winbond.com>
		Dezheng Shen	<dzshen AT gmail.com>

		
    $Author: dzshen $
    $Id: wbdebug.h,v 1.5.2.2 2006/06/14 07:17:06 dzshen Exp $

    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
        32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core
*/

#ifndef _WB_DEBUG_H_
#define _WB_DEBUG_H_

#include <asm/io.h>
#include <linux/delay.h>
#include <linux/version.h>

//enable/disable macro for debugging output
//#define WB_DEBUG
//#define WB_DEBUG_SCSI
//#define WB_DEBUG_INTR
//#define WB_DEBUG_THREAD

#define TRUE	1
#define FALSE	0

#define WB_VENDOR_ID 0x1050

#define WB_DRV_NAME		"wbstorage"
#define WB_DEBUG_HDR		WB_DRV_NAME ":" WB_STRINGIFY(__FILE__) 
":"WB_STRINGIFY(__LINE__) ":"
#define WB_STRINGIFY_HELPER(n)	#n
#define WB_STRINGIFY(n)         WB_STRINGIFY_HELPER(n)

#ifdef  WB_DEBUG
#define ENTER()				printk( WB_DRV_NAME ":" "ENTERING %s\n", __FUNCTION__ );
#define LEAVE()				printk( WB_DRV_NAME ":" "LEAVING %s\n",__FUNCTION__ );

#define WB_PRINTK_NEW_LINE()		printk("\n")
#define WB_PRINTK(...)			printk( __VA_ARGS__ )
#define WB_PRINTK_HDR(...)		printk( WB_DEBUG_HDR                 \
						 __VA_ARGS__ )
#define WB_PRINTK_ERROR(...)		printk( WB_DEBUG_HDR                 \
						 "ERROR: " __VA_ARGS__ )
#define WB_PRINTK_SCSI(...)		printk( WB_DEBUG_HDR                 \
						"SCSI command: " __VA_ARGS__ )
#define WB_PRINTK_ERROR_SCSI(...)	printk( WB_DEBUG_HDR                 \
						"ERROR:SCSI command: " __VA_ARGS__ )
#define WB_PRINTK_INTR(...)		printk( WB_DEBUG_HDR                 \
						"INTR: " __VA_ARGS__ )
#define WB_PRINTK_ERROR_INTR(...)	printk( WB_DEBUG_HDR                 \
						 "ERROR:INTR: " __VA_ARGS__ )

#define WB_PRINTK_THREAD(...)		printk( WB_DEBUG_HDR                 \
						"THREAD: " __VA_ARGS__ )

#else
#define ENTER()
#define LEAVE()

#define WB_PRINTK_NEW_LINE()
#define WB_PRINTK(...)
#define WB_PRINTK_HDR(...)
#define WB_PRINTK_ERROR(...)		printk( WB_DEBUG_HDR               \
					      "ERROR: " __VA_ARGS__ )
#if defined WB_DEBUG_SCSI
#define WB_PRINTK_SCSI(...)		printk( WB_DEBUG_HDR               \
                                               "SCSI: " __VA_ARGS__ )
#else
#define WB_PRINTK_SCSI(...)
#endif
#define WB_PRINTK_ERROR_SCSI(...)	printk( WB_DEBUG_HDR               \
                                               "ERROR:SCSI command: " 
__VA_ARGS__ )
#if defined WB_DEBUG_INTR
#define WB_PRINTK_INTR(...)		printk( WB_DEBUG_HDR               \
                                               "INTR: " __VA_ARGS__ )
#else
#define WB_PRINTK_INTR(...)
#endif
#define WB_PRINTK_ERROR_INTR(...)	printk( WB_DEBUG_HDR              \
					   "ERROR:INTR: " __VA_ARGS__ )
#if defined WB_DEBUG_THREAD
#define WB_PRINTK_THREAD(...)		printk( WB_DEBUG_HDR           \
						"THREAD: " __VA_ARGS__ )
#else
#define WB_PRINTK_THREAD(...)
#endif
#endif

#endif				/* _WB_DEBUG_H_ */
/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>

    $Author: dzshen $
    $Id: wbmscard.h,v 1.8.2.3 2006/06/14 07:20:28 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_MS_CARD_H_
#define _WB_MS_CARD_H_

#include <asm/byteorder.h>
#include <linux/types.h>
#include "wbvirtualdev.h"
#include "wbmsreader.h"
#include "wbtable.h"

#define MS_PAGE_SIZE		(512)

#define MS_MAX_BOOT_BLOCK_NUM	(12)
//---------------------card type--------------------------
#define WDEV_UNKNOWN			(0x00)
#define WDEV_MS				(0x01)
#define WDEV_MSPRO			(0x02)
#define WDEV_MS_IO			(0x03)
#define WDEV_MSPRO_IO			(0x04)

#define WRW_READ			(0x01)
#define WRW_WRITE			(0x02)

//---------------------MS/MSPro Command------------------
#define TPC_CODE(tpc)			(((u8)(((u8)(tpc))<<4)) |(~((u8)(tpc)) & 0x0F))
#define TPC_READ_LONG_DATA		TPC_CODE(0x2)	//TPC: 0010
#define TPC_READ_SHORT_DATA		TPC_CODE(0x3)	//TPC: 0011
#define TPC_READ_REG			TPC_CODE(0x4)	//TPC: 0100
#define TPC_GET_INT			TPC_CODE(0x7)	//TPC: 0111
#define TPC_WRITE_LONG_DATA		TPC_CODE(0xD)	//TPC: 1101
#define TPC_WRITE_SHORT_DATA		TPC_CODE(0xC)	//TPC: 1100
#define TPC_WRITE_REG			TPC_CODE(0xB)	//TPC: 1011
#define TPC_SET_RW_REG_ADRS		TPC_CODE(0x8)	//TPC: 1000
#define TPC_SET_CMD			TPC_CODE(0xE)	//TPC: 1110
#define TPC_EX_SET_CMD			TPC_CODE(0x9)	//TPC: 1001

//MS Command Parameter
#define MS_CP_BLOCK			(0)
#define MS_CP_PAGE			(0x20)
#define MS_CP_EXTRA			(0x40)
#define MS_CP_OVERWRITE			(0x80)

//MS Memory Access Command
#define MS_BLOCK_READ			(0xAA)
#define MS_BLOCK_WRITE			(0x55)
#define MS_BLOCK_END			(0x33)
#define MS_BLOCK_ERASE			(0x99)
#define MS_FLASH_STOP			(0xCC)

//MS Function Command
#define MS_SLEEP			(0x5A)
#define MS_CLEAR_BUF			(0xC3)
#define MS_RESET			(0x3C)

//MSPro Memory Access Command
#define MSPRO_READ_DATA			(0x20)
#define MSPRO_WRITE_DATA		(0x21)
#define MSPRO_READ_ATRB			(0x24)
#define MSPRO_STOP			(0x25)
#define MSPRO_ERASE			(0x26)
#define MSPRO_SET_IBD			(0x46)
#define MSPRO_GET_IBA			(0x47)

//MSPro Function Command
#define MSPRO_FORMAT			(0x10)
#define MSPRO_SLEEP			(0x11)

//MS register
#define MSREG_INT_CMDNK			(0x01)
#define MSREG_INT_BREQ			(0x20)
#define MSREG_INT_ERR			(0x40)
#define MSREG_INT_CED			(0x80)

#define MSREG_STATUS0_WP		(0x01)
#define MSREG_STATUS0_SL		(0x02)
#define MSREG_STATUS0_BF		(0x10)
#define MSREG_STATUS0_BE		(0x20)
#define MSREG_STATUS0_FB0		(0x40)
#define MSREG_STATUS0_MB		(0x80)

#define MSREG_STATUS1_UCFG		(0x01)
#define MSREG_STATUS1_FGER		(0x02)
#define MSREG_STATUS1_UCEX		(0x04)
#define MSREG_STATUS1_EXER		(0x08)
#define MSREG_STATUS1_UCDT		(0x10)
#define MSREG_STATUS1_DTER		(0x20)
#define MSREG_STATUS1_FBI		(0x40)
#define MSREG_STATUS1_MB		(0x80)

#define MSREG_SYSTEM_PAM		(0x08)

//MS page Extra Data Area
//  Overwrite Flag
#define MS_OVERWRITE_BLOCK_STATUS		(0x80)
#define OVERWRITE_BLOCK_OK			(0x80)
#define OVERWRITE_BLOCK_NG			(0x00)

#define MS_OVERWRITE_PAGE_STATUS		(0x60)
#define OVERRITE_PAGE_OK			(0x60)
#define OVERRITE_PAGE_NG			(0x40)
#define OVERRITE_PAGE_UDEF			(0x20)
#define OVERRITE_PAGE_ERROR			(0x00)
#define OVERWRITE_USED_UPDATING			(0x00)
#define OVERWRITE_ERASED_WRITTEN		(0x10)

#define MS_OVERWRITE_UPDATA_STATUS		(0x10)
#define MS_OVERWRITE_FORMAT_RESERVED		(0x0F)

//Management Flag
#define MS_MANAGEMENT_ACCESS			(0x20)
#define MS_MANAGEMENT_COPY			(0x10)
#define MS_MANAGEMENT_TRANS_TABLE		(0x08)
#define MS_MANAGEMENT_SYSTEM			(0x04)

#define MSPROREG_INT_CED			(0x80)
#define MSPROREG_INT_ERR			(0x40)
#define MSPROREG_INT_BREQ			(0x20)
#define MSPROREG_INT_CMDNK			(0x01)

#define MSPROREG_STATUS_ES			(0x80)
#define MSPROREG_STATUS_SL			(0x02)
#define MSPROREG_STATUS_WP			(0x01)

#define MSPROREG_SYSTEM_SRAC			(0x80)

typedef struct tag_wbms_extra_data {
	u8 overwrite_flag;
	u8 management_flag;
	u16 physical_address;
	u8 reserved[5];
	u8 extra_ecc;
	u8 data_area_ecc;
} __attribute__ ((packed)) wbms_extra_data_t;

#define MS_BOOT_BLOCK_ID			(0x0001)
//Header
typedef struct tag_wbms_boot_header {
	u16 block_id;
	u16 format_reserved;
	u8 reserved0[184];
	u8 data_entry;
	u8 reserved1[179];
} __attribute__ ((packed)) wbms_boot_header_t;

//System Entry
typedef struct tag_wbms_system_entry_item {
	u32 start_addr;
	u32 data_size;
	u8 data_type_id;
	u8 reserved[3];
} __attribute__ ((packed)) wbms_system_entry_item_t;

typedef struct tag_wbms_system_entry {
	wbms_system_entry_item_t disabled_block;
	wbms_system_entry_item_t cis_idi;
	u8 reserved[24];
} __attribute__ ((packed)) wbms_system_entry_t;

//Boot & Attribute Information
typedef struct tag_wbms_boot_attribute_information {
	u8 memorystick_class;
	u8 format_unique_value1;
	u16 block_size;
	u16 number_of_block;
	u16 number_of_effective_block;
	u16 page_size;
	u8 extr_data_size;
	u8 format_unique_value2;
	u64 assembly_time;
	u8 format_unique_value3;
	u8 serial_number[3];
	u8 assembly_manufacturer_code;
	u8 assembly_model_code[3];
	u16 memory_mamufacturer_code;
	u16 memory_device_code;
	u16 implemented_capacity;
	u8 format_unique_value4[2];
	u8 vcc;
	u8 vpp;
	u16 controller_number;
	u16 controller_function;
	u8 reserved1[9];
	u8 transfer_supporting;
	u16 format_unique_value5;
	u8 format_type;
	u8 memorystick_application;
	u8 device_type;
	u8 reserved2[22];
	u8 format_uniqure_value6[2];
	u8 reserved3[15];
} __attribute__ ((packed)) wbms_boot_attribute_information_t;

typedef struct tag_wbms_boot_block_page0 {
	wbms_boot_header_t header;
	wbms_system_entry_t entry;
	wbms_boot_attribute_information_t attribute;
} __attribute__ ((packed)) wbms_boot_block_page0_t;

typedef struct tag_wbms_idi {
	u16 general_config;
	u16 logical_cylinders;
	u16 reserved;
	u16 logical_heads;
	u16 track_size;
	u16 sector_size;
	u16 sectors_per_track;
	u16 msw;
	u16 lsw;
	u16 reserved0;
	u8 serial_number[20];
	u16 buffer_type;
	u16 buffer_size_increments;
	u16 long_command_ecc;
	u8 firmware_version;
	u8 model_name;
	u16 reserved1;
	u16 pio_mode_number;
	u16 dma_mode_number;
	u16 field_validity;
	u16 current_logical_cylinders;
	u16 current_logical_heads;
	u16 current_sectors_per_track;
	u32 current_sector_capality;
	u16 mutiple_sector_setting;
	u32 addressable_sectors;
	u16 single_word_dma;
	u16 multi_word_dma;
	u8 reserved2[128];
} __attribute__ ((packed)) wbms_idi;

//----------------Card Register----------------
//MS register
typedef struct tag_wbms_status_register {
	u8 reserved1;
	u8 interrupt;
	u8 status0;
	u8 status1;
	u8 type;
	u8 reserved2;
	u8 category;
	u8 class;
	u8 reserved3[8];
} __attribute__ ((packed)) wbms_status_register_t;

typedef struct tag_wbms_param_register {
	u8 system;
	u8 block_address[3];
	u8 cp;
	u8 page_address;
} __attribute__ ((packed)) wbms_param_register_t;

typedef struct tag_wbms_extra_data_register {
	u8 overwrite_flag;
	u8 management_flag;
	u16 logical_address;
} __attribute__ ((packed)) wbms_extra_data_register_t;
typedef struct tag_wbms_register {
	wbms_status_register_t status;
	wbms_param_register_t params;
	wbms_extra_data_register_t extra;
} __attribute__ ((packed)) wbms_register_t;

//MSPro register
typedef struct tag_wbmspro_status_register {
	u8 reserved1;
	u8 interrupt;
	u8 status;
	u8 reserved2;
	u8 type;
	u8 reserved3;
	u8 category;
	u8 class;
	u8 reserved4[8];
} __attribute__ ((packed)) wbmspro_status_register_t;

typedef struct tag_wbmspro_param_register {
	u8 system;
	u16 data_count;
	u32 data_address;
	u8 cmd_param;
} __attribute__ ((packed)) wbmspro_param_register_t;

typedef struct tag_wbmspro_register {
	wbmspro_status_register_t status;
	wbmspro_param_register_t params;
} __attribute__ ((packed)) wbmspro_register_t;

typedef struct tag_wbmspro_attribute {
	u16 signature;
	u16 version;
	u8 device_information_entry_count;
	u8 reserved[11];
} __attribute__ ((packed)) wbmspro_attribute_t;

#define MSPRO_DEVINFOID_SYSINFO				(0x10)
#define MSPRO_DEVINFOID_MODELNAME			(0x15)
#define MSPRO_DEVINFOID_MBR				(0x20)
#define MSPRO_DEVINFOID_PBR16				(0x21)
#define MSPRO_DEVINFOID_PBR32				(0x22)
#define MSPRO_DEVINFOID_SPECFILEVALUES1			(0x25)
#define MSPRO_DEVINFOID_SPECFILEVALUES2			(0x26)
#define MSPRO_DEVINFOID_IDENTIFYDEVINFO			(0x30)

typedef struct tag_wbmspro_device_info_entry_item {
	u32 address;
	u32 size;
	u8 info_id;
	u8 reserved[3];
} __attribute__ ((packed)) wbmspro_device_info_entry_item_t;

typedef struct tag_wbmspro_device_info_entry {
	wbmspro_device_info_entry_item_t entry[12];
	u8 reserved[256];
} __attribute__ ((packed)) wbmspro_device_info_entry_t;

typedef struct tag_wbmspro_sys_info {
	u8 class;		// must be ?
	u8 reserved;		// see below
	u16 block_size;		// n KB
	u16 block_count;	// number of physical block
	u16 user_block_count;	// number of logical block
	u16 page_size;		// must be 0x200
	u8 reserved1[2];	// MS original Extra data size and format reserved
	u8 assembly_date[8];
	u32 serial_number;
	u8 assembly_maker_code;
	u8 assembly_model_code[3];
	u16 memory_maker_code;
	u16 memory_model_code;
	u8 reserved2[4];	//reserved[6]
	u8 vcc;
	u8 vpp;
	u16 controller_number;
	u16 controller_function;
	u16 start_sector;
	u16 unit_size;
	u8 ms_sub_class;
	u8 reserved3[4];
	u8 interface_type;
	u16 controller_code;
	u8 format_type;
	u8 reserved4;;
	u8 device_type;
	u8 reserved5[7];
	u8 mspro_id[16];
	u8 reserved6[16];
} __attribute__ ((packed)) wbmspro_sys_info_t;

typedef struct tag_wbmspro_mbr {
	u8 default_boot_partition;
	u8 start_head;
	u8 start_cylinder;
	u8 partition_type;
	u8 end_head;
	u8 end_sector;
	u8 end_cylinder;
	u32 start_sectors;
	u32 sectors_per_partition;
} __attribute__ ((packed)) wbmspro_mbr_t;

#define MS_IDI_OFFSET				(256)
typedef struct tab_wbmspro_identify_dev_info {
	u16 cylinders;
	u16 heads;
	u16 byte_per_track;
	u16 byte_per_sector;
	u16 sectors_per_track;
	u8 reserved[6];
} __attribute__ ((packed)) wbmspro_identify_dev_info_t;
//Global variable
typedef struct tag_wbms_card_info {
	wbms_register_t *ms_register;
	wbmspro_register_t *mspro_registe;
	unsigned char registers[0x20];

	unsigned char dev_type;
	unsigned char rw_capality;
	unsigned char transfer_mode;

	unsigned int block_size;
	unsigned int page_pre_block;
	unsigned int number_of_physical_block;

	unsigned int number_of_boot_block;
	unsigned int boot_block_num[2];

	unsigned short cylinders;
	unsigned short heads;
	unsigned int sectors;
	unsigned short sectors_per_track;
	unsigned int sector_size;

} __attribute__ ((packed)) wbms_card_info_t;

//TPC layer
static inline int wbms_send_tpc(unsigned char cmd, unsigned char *buffer,
				int length);
static inline int tpc_read_long_data(void);
static inline int tpc_read_short_data(void);
static inline int tpc_read_reg(void);
static inline int tpc_get_int(void);
static inline int tpc_write_long_data(void);
static inline int tpc_write_short_data(void);
static inline int tpc_write_reg(unsigned char *buffer, int len);
static inline int tpc_set_cmd(unsigned char flash_cmd);
static inline int tpc_ex_set_cmd(unsigned char flash_cmd,
				 unsigned int block_addr, unsigned short size);
static inline int tpc_set_rw_reg_adrs(unsigned char read_adrs,
				      unsigned char read_size,
				      unsigned char write_adrs,
				      unsigned char write_size);

//MS interface layer
static int wbmspro_read_attribute(unsigned int page_address,
				  unsigned int num_page, unsigned char *buffer);
static int wbms_read_status_register(void);
static int wbms_write_register(int start_addr, unsigned char *buffer,
			       int length);
static int inline wbms_read_extra_register(void);
static int wbms_get_int(void);
static int inline wbms_set_rw_param(unsigned char cp,
				    unsigned int block_address,
				    unsigned char page_address);
static int wbms_read_page_extra(unsigned int block_address,
				unsigned short page_address);
static int inline wbms_write_page_extra(unsigned int physical,
					unsigned char page_index,
					unsigned char overwrite,
					unsigned short logical);

static int wbms_identification_card_type(void);

//MSPro function interface
static int wbmspro_set_wr_param(unsigned int lba, unsigned short count);

#endif	/* _WB_MS_CARD_H_ */

/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>


    $Author: sjin $
    $Id: wbmsreader528.h,v 1.10.2.4 2006/06/14 07:35:46 sjin Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
        32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_MS_READER_528_H
#define _WB_MS_READER_528_H
#include <linux/version.h>
#include <linux/types.h>
#include <linux/module.h>
#include <linux/string.h>
#include <linux/gfp.h>

#include "wbmsreader.h"
#include <linux/mm.h>
#include <linux/types.h>
#include <linux/slab.h>
#include <linux/list.h>
#include <linux/proc_fs.h>
#include <linux/ctype.h>

#include <linux/time.h>
#include <linux/spinlock.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/wait.h>
#include <linux/interrupt.h>
#include <linux/pci.h>
#include <asm/io.h>
#include <asm/dma.h>
#include "wbdebug.h"
#include "wbmsreader.h"
#include "wbmscard.h"

#define WMAX_POLLING_CMD			(1000000)
#define WMAX_POLLING				(1000000)

#define W528MS_VENDOR_ID    			(0x1050)
#define W528MS_DEVICE_ID    			(0x8482)

#define WPCI_ICR				(0x9EC)
#define WPCI_ISR				(0x9F0)

#define WIO_DEVICE_ISR				(0x410)
#define WIO_DMA_SD				(0x4f0)
#define WIO_DMA_MS				(0x4f4)
#define WIO_DMA_SX				(0x4f8)

#define WIO_DMA_INT_MSK				(0x04)
#define WIO_DMA_INT_SRC				(0x0C)
#define WIO_DMA_CH0_CSR				(0x20)
#define WIO_DMA_CH0_SZ				(0x24)
#define WIO_DMA_CH0_SA				(0x28)
#define WIO_DMA_CH0_DA				(0x30)
#define WIO_DMA_CH1_CSR				(0x40)
#define WIO_DMA_CH1_SZ				(0x44)
#define WIO_DMA_CH1_SA				(0x48)
#define WIO_DMA_CH1_DA				(0x50)
#define WIO_DMA_CH2_CSR				(0x60)
#define WIO_DMA_CH2_SZ				(0x64)
#define WIO_DMA_CH2_SA				(0x68)
#define WIO_DMA_CH2_DA				(0x70)

#define WIO_BASE				(0x600)
#define WIO_CMDR					(WIO_BASE + 0x00)
#define WIO_DFR						(WIO_BASE + 0x04)
#define WIO_MSCR1					(WIO_BASE + 0x08)
#define WIO_MSCR2					(WIO_BASE + 0x0C)
#define WIO_ICR						(WIO_BASE + 0x10)
#define WIO_ISR1					(WIO_BASE + 0x14)
#define WIO_ISR2					(WIO_BASE + 0x18)
#define WIO_MSSR					(WIO_BASE + 0x1C)

#define WPCI_ICR_INT_ENABLE			(0x01)
#define WPCI_ICR_SOFTWARE_RESET_ALL		(0x20)
#define WPCI_ICR_SOFTWARE_RESET			(0x40)

#define WPCI_ISR_STATUS				(0x01)

#define WDEVICE_ISR_DMA				(0x01)
#define WDEVICE_ISR_SD				(0x02)
#define WDEVICE_ISR_MS				(0x04)
#define WDEVICE_ISR_SMXD			(0x08)
#define WDEVICE_ISR_SDDMA_ERROR			(0x10)
#define WDEVICE_ISR_MSDMA_ERROR			(0x20)
#define WDEVICE_ISR_SMXDDMA_ERROR		(0x40)

#define WMSCR2_PF				(0x40)
#define WMSCR2_FIFORST				(0x20)
#define WMSCR2_SOFTRST				(0x10)
#define WMSCR2_PWRCTRL				(0x08)
#define WMSCR2_SWITCHNMOS			(0x04)

#define WICR_CRC				(0x40)
#define WICR_RDYTO				(0x20)
#define WICR_BS0INT				(0x10)
#define WICR_INSINT				(0x01)

#define WISR1_INTP				(0x80)
#define WISR1_FIFOUSED				(0x78)
#define WISR1_INS				(0x01)

#define WISR2_INTP				(0x80)
#define WISR2_CRC				(0x40)
#define WISR2_RDYTO				(0x20)
#define WISR2_BS0				(0x10)
#define WISR2_CED				(0x08)
#define WISR2_ERR				(0x04)
#define WISR2_BREQ				(0x02)
#define WISR2_CMDNK				(0x01)

#define WMSSR_CRC				(0x10)
#define WMSSR_INS				(0x08)
#define WMSSR_DFF				(0x04)
#define WMSSR_DFE				(0x02)
#define WMSSR_RDY4CMD				(0x01)

#define WDMA_INT_SRC_CH0			(0x01)
#define WDMA_INT_SRC_CH1			(0x02)
#define WDMA_INT_SRC_CH2			(0x04)

#define WDMA_CHCSR_EN				(0x01)
#define WDMA_CHCSR_DSTSEL			(0x02)
#define WDMA_CHCSR_SRCSEL			(0x04)
#define WDMA_CHCSR_INCDST			(0x08)
#define WDMA_CHCSR_INCSRC			(0x10)
#define WDMA_CHCSR_INTERR			(0x20000)
#define WDMA_CHCSR_INTDONE			(0x40000)

#define WDMA_CHCSR_WRITE			( WDMA_CHCSR_EN | WDMA_CHCSR_DSTSEL \
						  | WDMA_CHCSR_INCSRC | WDMA_CHCSR_INTERR | WDMA_CHCSR_INTDONE )
#define WDMA_CHCSR_READ				( WDMA_CHCSR_EN | WDMA_CHCSR_SRCSEL \
						  | WDMA_CHCSR_INCDST | WDMA_CHCSR_INTERR | WDMA_CHCSR_INTDONE )

//system status definition
#define WSYS_STATUS_INTR_CARD			(1)
#define WSYS_STATUS_INTR_CRC			(1<<1)
#define WSYS_STATUS_INTR_BS0			(1<<2)
#define WSYS_STATUS_INTR_BS0_TOE		(1<<3)
#define WSYS_STATUS_INTR_RDY_TOE		(1<<4)
#define WSYS_STATUS_INTR_FIFO_THRESHOLD		(1<<5)
#define WSYS_STATUS_INTR_TC			(1<<7)
#define WSYS_STATUS_INTR_DMA			(1<<8)
typedef struct tag_wb528ms_reader {
	// base io address 0
	unsigned long mem_addr0;
	unsigned long mem_flag0;

	// base io address 1
	unsigned long mem_addr1;
	unsigned long mem_flag1;

	struct pci_dev *pci_dev;
	unsigned char irq;
	unsigned char dma;
	dma_addr_t bus_addr;

	unsigned char card_exist;
	unsigned char medium_changed;
	unsigned char card_type;

	volatile unsigned int sys_status;

	//help thread wait queue
	wait_queue_head_t space_helper_thread_wait_queue;
	wait_queue_head_t *helper_thread_wait_queue;
} wb528ms_reader_t;

static unsigned int inline wb528ms_pci_inl(unsigned offset);
static void inline wb528ms_pci_outl(volatile unsigned int value,
				    unsigned offset);
static unsigned int inline wb528ms_inl(unsigned offset);
static void inline wb528ms_outl(volatile unsigned int value, unsigned 
offset);
static unsigned short inline wb528ms_inw(unsigned offset);
static void inline wb528ms_outw(volatile unsigned short value, unsigned 
offset);
static unsigned char inline wb528ms_inb(unsigned offset);
static void inline wb528ms_outb(volatile unsigned char value, unsigned 
offset);

static void inline wb528ms_set_interface(unsigned int);
static inline void wb528ms_power_up(void);
static inline void wb528ms_power_down(void);
static inline void wb528ms_fifo_reset(void);
static int inline wb528ms_pio_data(unsigned char *buff, unsigned int length,
				   unsigned char read_wrt_flag);
static int inline wb528ms_dma_data(unsigned char *buff, unsigned int length,
				   unsigned char read_wrt_flag);
static void wb528ms_set_fifo_size(unsigned int length);
static int wb528ms_check_cmd_ready(void);
static int wb528ms_init_card(void);
static int wb528ms_card_exist(void);
static int wb528ms_software_reset(void);
static irqreturn_t wb528ms_do_intr_handler(int irq, void *dev_id,
					   struct pt_regs *regs);
static void inline __init wb528ms_init_data(void);
#endif
/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>

    $Author: dzshen $
    $Id: wbmsreader.h,v 1.5.2.3 2006/06/14 07:20:28 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_MS_READER_H_
#define _WB_MS_READER_H_

#define WREADER_PIO		0
#define WREADER_DMA		1

static void *wbreader_detect(void);
static int wbreader_release(void);

//send TPC Command and wait untill INT, but needn't justify cmd result
//Result: 

//              If CMD send (not exec) successful and MS working at 
Parallel Mode,
//                 bit3 to bit0 should be |CED|ERR|BREQ|CMDNK|, or it 
should be 0.
//           If CMD send error, such as TIMEOUT,the result should below 
zero.
static int wbreader_issue_cmd(unsigned char cmd, unsigned char *param,
			      int length);
// Read TPC Command result (from FIFO or orther register)
//static int wbreader_get_cmd_response(unsigned char *buff, int length);
static int wbreader_prepare_transfer(unsigned char *buff, unsigned int 
length,
				     unsigned char read_wrt_flag);
static int wbreader_transfer_data(unsigned char *buff, unsigned int length,
				  unsigned char read_wrt_flag, int dma_mode);

#define WSTATE_FIFO_SIZE		1
#define WSTATE_PRESENT			(1<<1)
#define WSTATE_CHANGED			(1<<2)
#define WSTATE_TRANSFER_CAPABILITY			(1 << 3)
#define WSTATE_CARD_TYPE						(1<<4)
static int wbreader_get_state(int which_state);
static int wbreader_set_state(int which_state, int state);

//whichconfig defined here
#define WCONFIG_INTERFACE	0x01
#define WCONFIG_CLOCK		0x02
#define WCONFIG_PREPARE_INIT_CARD	0x04

#define WIF_SERIAL		0
#define WIF_PARALLEL	1

static int wbreader_set_config(unsigned char which_config, unsigned int 
config);

#endif				/* _WB_MS_READER_H_ */
/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>


    $Author: dzshen $
    $Id: wbscsi.h,v 1.5.2.3 2006/06/14 07:17:06 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_SCSI_H_
#define _WB_SCSI_H_

#include "wbdebug.h"

#include <linux/blkdev.h>
#include <scsi/scsi_host.h>
#include <scsi/scsi_cmnd.h>
#include <scsi/scsi_device.h>

#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/module.h>
#include <scsi/scsi.h>

// for initializing the host
#define WB_MAX_TARGETS		1
#define WB_MAX_LUNS		1
#define WB_MAX_SECTORS		64
#define WB_UNCHECKED_ISA_DMA	0

// don't make this larger than 8, possible values
// are 0, 2, 4, 8
#define WB_SG_TABLE_SIZE				64
#define WB_LOGICAL_BLK_SIZE				512	// in bytes

#define WB_CMD_RESULT( x, y, c )	(((x)<< 16 ) | ((y) << 8 ) | ((c) << 1) )
#define WB_COMPUTE_START_LBA(cmd)	(((unsigned int)cmd->cmnd[2] << 24 ) + \
					 ((unsigned int)cmd->cmnd[3] << 16 ) + \
					 ((unsigned int)cmd->cmnd[4] << 8)   + \
					 ((unsigned int)cmd->cmnd[5] ));
#define WB_COMPUTE_NUM_BLK(cmd)	(((unsigned short)cmd->cmnd[7] << 8 ) + \
				 ((unsigned short)cmd->cmnd[8] ))

typedef struct scsi_cmnd Scsi_Cmnd;
typedef struct scsi_host_template Scsi_Host_Template;
typedef struct scsi_device Scsi_Device;

// this wrapper is only used for SCSI read/write command
typedef struct tag_wb_scsi_cmd_wrapper {
	struct tag_wb_scsi_cmd_wrapper *nextCmd;
	Scsi_Cmnd *cmd;
} wb_scsi_cmd_wrapper_t;

//Inquiry Data Format refer to INQUIRYDATA in src
typedef struct tag_wb_scsi_inquiry_data {
	unsigned char dev_type;
	unsigned char dev_type_modifier:7;
	unsigned char removable_medium:1;
	unsigned char ver;
	unsigned char response_data_format;
	unsigned char additional_len;
	unsigned char reserved[2];
	unsigned char soft_reset:1;
	unsigned char cmd_queue:1;
	unsigned char reserved2:1;
	unsigned char linked_cmds:1;
	unsigned char sync:1;
	unsigned char wide16b:1;
	unsigned char wide32b:1;
	unsigned char relative_addr:1;
	unsigned char vendor_id[8];
	unsigned char prod_id[16];
	unsigned char prod_rev_level[4];
} wb_scsi_inquiry_data_t;

// Read Capacity Data Format
typedef struct tag_wb_scsi_capacity {
	unsigned int lba;
	unsigned int len;
} wb_scsi_capacity_t;

// Sense Data Format - Mode Page Header
typedef struct tag_wb_scsi_mode_page_header {
	unsigned char data_len;
	unsigned char medium_type;
	unsigned char dev_spec_param;
	unsigned char blk_desc_len;
} __attribute__ ((packed)) wb_scsi_mode_page_header_t;

typedef struct tag_wb_host_data_t {
	unsigned char medium_valid;
	unsigned char notice_upper_scsi_layer;

#define WB_SYS_STATE_TEST			( 1 )
#define WB_SYS_STATE_RMMOD			( 1 << 1 )
#define WB_SYS_STATE_RMMOD_ACK			( 1 << 2 )
#define WB_SYS_STATE_QUEUE_CMD_OK		( 1 << 3 )
	volatile unsigned int sys_state;

	wb_scsi_cmd_wrapper_t space_cmd_wrapper;
	wb_scsi_cmd_wrapper_t *cmd_wrapper;

	//help thread wait queue
	struct semaphore space_semaphore;
	struct semaphore *semaphore;

	// the extra 4096 handles w528 DMA bug
	char scratch[WB_SG_TABLE_SIZE * 512 + 4096];
} wb_host_data_t;

static int __init wb_init_host_data(wb_host_data_t * host_data);
static void wb_stop_helper_kernel_thread(wb_host_data_t * host_data);
static void wb_copy_sgtable_to_scratch(Scsi_Cmnd * cmd, char *scratch);
static void wb_copy_scratch_to_sgtable(char *scratch, Scsi_Cmnd * cmd);
static void wb_make_sense_buffer(Scsi_Cmnd *, int, int, int);
static void wb_chk_valid_medium(wb_host_data_t * hostData);
static int wb_unit_ready(Scsi_Cmnd *);
static int wb_helper_kernel_thread(void *param);
static int wb_process_scsi_cmd(Scsi_Cmnd * cmd);

// execute scsi cmd
static void wb_scsi_test_unit_ready(Scsi_Cmnd *);
static void wb_scsi_inquiry(Scsi_Cmnd *);
static void wb_scsi_start_stop(Scsi_Cmnd *);
static void wb_scsi_mode_sense(Scsi_Cmnd *);
static void wb_scsi_read_capacity(Scsi_Cmnd *);
static void wb_scsi_allow_medium_removal(Scsi_Cmnd *);
static void wb_scsi_read_wrt(Scsi_Cmnd *, unsigned char readCmd);
static void wb_scsi_request_sense(Scsi_Cmnd *);
static void wb_scsi_format_unit(Scsi_Cmnd *);
// entry functions
static void *__init wb_detect(Scsi_Host_Template *);
static int __exit wb_release(struct Scsi_Host *);
//static int       wb_ioctl(Scsi_Device *dev,int cmd,void *arg);
static const char *wb_info(struct Scsi_Host *);
static int wb_queue_cmd(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));

static int wb_eh_abort(Scsi_Cmnd *);
static int wb_eh_reset(Scsi_Cmnd *);
//FIXME, remember to copy this function from Chsun0's memory stick codes
//static int         wb_bios_param(Scsi_Device *,struct block_device 
*,sector_t, int[]);

#define WB_DRIVER {							\
	info:           wb_info,					\
			queuecommand:   wb_queue_cmd,			\
			eh_abort_handler:wb_eh_abort,			\
			eh_host_reset_handler:wb_eh_reset,		\
			can_queue:      1,				\
			this_id:        -1,				\
			sg_tablesize:   WB_SG_TABLE_SIZE,		\
			cmd_per_lun:    1,				\
			present:        0,				\
			unchecked_isa_dma: WB_UNCHECKED_ISA_DMA,	\
			use_clustering: ENABLE_CLUSTERING,		\
			module:		THIS_MODULE,			\
			}

#endif				/* _WB_SCSI_H_ */

/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>


    $Author: dzshen $
    $Id: wbtable.h,v 1.4.2.2 2006/06/14 07:17:06 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_TABLE_H_
#define _WB_TABLE_H_

// those are special values, don't change them at will
#define WB_TABLE_DEFECT	(0xfffe)
#define WB_TABLE_UNUSED	(0xffff)

#define WB_MAX_NUM_PHYSICAL		(512)
// for segment 0, only (496 - 2 = 494) logical blocks are mapped
// those two blocks are reserved for book blocks
#define WB_MAX_NUM_LOGICAL		(496)
#define WB_MAX_NUM_SEG			(16)

// block size: 16KB/10h, 8KB/08h, segment = total_physical_blk / 
WB_MAX_NUM_PHYSICAL
int wbtable_init(unsigned int blk_size, unsigned int total_physical_blk);

int wbtable_finit(void);

int wbtable_add_link_logical_physical(unsigned int logical,
				      unsigned int physical);

int wbtable_add_link_physical_logical(unsigned int physical,
				      unsigned int logical);

// this link must exist; otherwise, an warning message is printed
int wbtable_del_link(unsigned int physical, unsigned int logical);

unsigned int wbtable_get_physical(unsigned int logical);
unsigned int wbtable_get_logical(unsigned int physical);

unsigned int wbtable_get_seg(unsigned int lba);

unsigned int wbtable_get_unused_physical(unsigned int seg);

unsigned int wbtable_add_link(unsigned int logical, unsigned int physical);

int wbtable_dump(void);

int wbtable_sanity_chk(void);

static int wbtable_chk_limit(unsigned int seg, unsigned int physical,
			     unsigned int logical);

#endif				/* _WB_TABLE_H_ */
/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>


    $Author: dzshen $
    $Id: wbvirtualdev.h,v 1.4.2.2 2006/06/14 07:17:06 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#ifndef _WB_VIRTUAL_DEV_H_
#define _WB_VIRTUAL_DEV_H_

static void *wbvdev_detect(void);
static int wbvdev_release(void);

// the number of total sectors in this virtual device
static int wbvdev_get_capacity(void);

static int wbvdev_read_wrt(unsigned int start_lba, unsigned int length,
			   unsigned char *buffer, unsigned char read_wrt_flag);

#define WB_VIRTUAL_STATE_PROTECTED	(1)
#define WB_VIRTUAL_STATE_PRESENT	(1 << 1)
#define WB_VIRTUAL_STATE_CHANGED	(1 << 2)
static unsigned char wbvdev_get_state(int which_state);
static void wbvdev_set_state(int which_state, unsigned char state);

static int wbvdev_init_card(void);

#endif				/* _WB_VIRTUAL_DEV_H_ */





===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
