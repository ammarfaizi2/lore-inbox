Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVECV1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVECV1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVECV1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:27:41 -0400
Received: from web21127.mail.yahoo.com ([216.136.227.192]:27987 "HELO
	web21127.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261727AbVECV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:27:16 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=gT3/SzGEpvVKLTl4RvvSGD9S6AIWvLXCXZiZOoq6SZ/EdSweBdC13c4Z8rcKD6vWfKboY5m0S8W7ROF2JdCxtBxW+IcV+vME8hQF+lodg5lBI1x5RX59ahO+zsKRbS44mwltJYYOF9TuWX5yE+ZFlRAw34bdIYid+V2Het+ZxI8=  ;
Message-ID: <20050503212715.94232.qmail@web21127.mail.yahoo.com>
Date: Tue, 3 May 2005 14:27:15 -0700 (PDT)
From: segin <segin11@yahoo.com>
Subject: Error in include/linux/mod_devicetable.h
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-360083758-1115155635=:93897"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-360083758-1115155635=:93897
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

The error occurs when compiling a program (dosemu) that uses the include file stated above.
I won't hog your mailboxes with useless infomation.

All the errors are 'parse errors'. I will examine the include file for bugs later...
All errors that pretain to this are attached, and the given include file is also attached.

WHAT I AM DOING/RUNNING/VERSIONS(all possible combinations):
gcc 3.3.5
Kernel 2.6.11, 2.6.11.8
dosemu 1.2.2, 1.3.1



Jeez... Is it just me or is it that most people today are too fucking retarded to use a computer?

Semper fi pengunius.
Webmaster of Segin's Open Source Den. 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-360083758-1115155635=:93897
Content-Type: text/plain; name="error.log"
Content-Description: error.log
Content-Disposition: inline; filename="error.log"

/usr/include/linux/mod_devicetable.h:18: error: parse error before "__u32"
/usr/include/linux/mod_devicetable.h:20: error: parse error before "class"
/usr/include/linux/mod_devicetable.h:21: error: parse error before "driver_data"
/usr/include/linux/mod_devicetable.h:31: error: parse error before "__u32"
/usr/include/linux/mod_devicetable.h:33: error: parse error before "model_id"
/usr/include/linux/mod_devicetable.h:34: error: parse error before "specifier_id"
/usr/include/linux/mod_devicetable.h:35: error: parse error before "version"
/usr/include/linux/mod_devicetable.h:36: error: parse error before "driver_data"
/usr/include/linux/mod_devicetable.h:99: error: parse error before "__u16"
/usr/include/linux/mod_devicetable.h:103: error: parse error before "idProduct"
/usr/include/linux/mod_devicetable.h:104: error: parse error before "bcdDevice_lo"
/usr/include/linux/mod_devicetable.h:105: error: parse error before "bcdDevice_hi"
/usr/include/linux/mod_devicetable.h:108: error: parse error before "bDeviceClass"
/usr/include/linux/mod_devicetable.h:109: error: parse error before "bDeviceSubClass"
/usr/include/linux/mod_devicetable.h:110: error: parse error before "bDeviceProtocol"
/usr/include/linux/mod_devicetable.h:113: error: parse error before "bInterfaceClass"
/usr/include/linux/mod_devicetable.h:114: error: parse error before "bInterfaceSubClass"
/usr/include/linux/mod_devicetable.h:115: error: parse error before "bInterfaceProtocol"
/usr/include/linux/mod_devicetable.h:118: error: parse error before "driver_info"
/usr/include/linux/mod_devicetable.h:135: error: parse error before "__u16"
/usr/include/linux/mod_devicetable.h:138: error: parse error before "dev_type"
/usr/include/linux/mod_devicetable.h:139: error: parse error before "cu_model"
/usr/include/linux/mod_devicetable.h:140: error: parse error before "dev_model"
/usr/include/linux/mod_devicetable.h:142: error: parse error before "driver_info"
/usr/include/linux/mod_devicetable.h:155: error: parse error before "__u8"
/usr/include/linux/mod_devicetable.h:160: error: parse error before "__u8"
/usr/include/linux/mod_devicetable.h:163: error: parse error before "__u8"
/usr/include/linux/mod_devicetable.h:165: error: parse error before '}' token


--0-360083758-1115155635=:93897
Content-Type: text/plain; name="mod_devicetable.h"
Content-Description: mod_devicetable.h
Content-Disposition: inline; filename="mod_devicetable.h"

/*
 * Device tables which are exported to userspace via
 * scripts/table2alias.c.  You must keep that file in sync with this
 * header.
 */

#ifndef LINUX_MOD_DEVICETABLE_H
#define LINUX_MOD_DEVICETABLE_H

#ifdef __KERNEL__
#include <linux/types.h>
typedef unsigned long kernel_ulong_t;
#endif

#define PCI_ANY_ID (~0)

struct pci_device_id {
	__u32 vendor, device;		/* Vendor and device ID or PCI_ANY_ID*/
	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
	kernel_ulong_t driver_data;	/* Data private to the driver */
};


#define IEEE1394_MATCH_VENDOR_ID	0x0001
#define IEEE1394_MATCH_MODEL_ID		0x0002
#define IEEE1394_MATCH_SPECIFIER_ID	0x0004
#define IEEE1394_MATCH_VERSION		0x0008

struct ieee1394_device_id {
	__u32 match_flags;
	__u32 vendor_id;
	__u32 model_id;
	__u32 specifier_id;
	__u32 version;
	kernel_ulong_t driver_data;
};


/*
 * Device table entry for "new style" table-driven USB drivers.
 * User mode code can read these tables to choose which modules to load.
 * Declare the table as a MODULE_DEVICE_TABLE.
 *
 * A probe() parameter will point to a matching entry from this table.
 * Use the driver_info field for each match to hold information tied
 * to that match:  device quirks, etc.
 *
 * Terminate the driver's table with an all-zeroes entry.
 * Use the flag values to control which fields are compared.
 */

/**
 * struct usb_device_id - identifies USB devices for probing and hotplugging
 * @match_flags: Bit mask controlling of the other fields are used to match
 *	against new devices.  Any field except for driver_info may be used,
 *	although some only make sense in conjunction with other fields.
 *	This is usually set by a USB_DEVICE_*() macro, which sets all
 *	other fields in this structure except for driver_info.
 * @idVendor: USB vendor ID for a device; numbers are assigned
 *	by the USB forum to its members.
 * @idProduct: Vendor-assigned product ID.
 * @bcdDevice_lo: Low end of range of vendor-assigned product version numbers.
 *	This is also used to identify individual product versions, for
 *	a range consisting of a single device.
 * @bcdDevice_hi: High end of version number range.  The range of product
 *	versions is inclusive.
 * @bDeviceClass: Class of device; numbers are assigned
 *	by the USB forum.  Products may choose to implement classes,
 *	or be vendor-specific.  Device classes specify behavior of all
 *	the interfaces on a devices.
 * @bDeviceSubClass: Subclass of device; associated with bDeviceClass.
 * @bDeviceProtocol: Protocol of device; associated with bDeviceClass.
 * @bInterfaceClass: Class of interface; numbers are assigned
 *	by the USB forum.  Products may choose to implement classes,
 *	or be vendor-specific.  Interface classes specify behavior only
 *	of a given interface; other interfaces may support other classes.
 * @bInterfaceSubClass: Subclass of interface; associated with bInterfaceClass.
 * @bInterfaceProtocol: Protocol of interface; associated with bInterfaceClass.
 * @driver_info: Holds information used by the driver.  Usually it holds
 *	a pointer to a descriptor understood by the driver, or perhaps
 *	device flags.
 *
 * In most cases, drivers will create a table of device IDs by using
 * USB_DEVICE(), or similar macros designed for that purpose.
 * They will then export it to userspace using MODULE_DEVICE_TABLE(),
 * and provide it to the USB core through their usb_driver structure.
 *
 * See the usb_match_id() function for information about how matches are
 * performed.  Briefly, you will normally use one of several macros to help
 * construct these entries.  Each entry you provide will either identify
 * one or more specific products, or will identify a class of products
 * which have agreed to behave the same.  You should put the more specific
 * matches towards the beginning of your table, so that driver_info can
 * record quirks of specific products.
 */
struct usb_device_id {
	/* which fields to match against? */
	__u16		match_flags;

	/* Used for product specific matches; range is inclusive */
	__u16		idVendor;
	__u16		idProduct;
	__u16		bcdDevice_lo;
	__u16		bcdDevice_hi;

	/* Used for device class matches */
	__u8		bDeviceClass;
	__u8		bDeviceSubClass;
	__u8		bDeviceProtocol;

	/* Used for interface class matches */
	__u8		bInterfaceClass;
	__u8		bInterfaceSubClass;
	__u8		bInterfaceProtocol;

	/* not matched against */
	kernel_ulong_t	driver_info;
};

/* Some useful macros to use to create struct usb_device_id */
#define USB_DEVICE_ID_MATCH_VENDOR		0x0001
#define USB_DEVICE_ID_MATCH_PRODUCT		0x0002
#define USB_DEVICE_ID_MATCH_DEV_LO		0x0004
#define USB_DEVICE_ID_MATCH_DEV_HI		0x0008
#define USB_DEVICE_ID_MATCH_DEV_CLASS		0x0010
#define USB_DEVICE_ID_MATCH_DEV_SUBCLASS	0x0020
#define USB_DEVICE_ID_MATCH_DEV_PROTOCOL	0x0040
#define USB_DEVICE_ID_MATCH_INT_CLASS		0x0080
#define USB_DEVICE_ID_MATCH_INT_SUBCLASS	0x0100
#define USB_DEVICE_ID_MATCH_INT_PROTOCOL	0x0200

/* s390 CCW devices */
struct ccw_device_id {
	__u16	match_flags;	/* which fields to match against */

	__u16	cu_type;	/* control unit type     */
	__u16	dev_type;	/* device type           */
	__u8	cu_model;	/* control unit model    */
	__u8	dev_model;	/* device model          */

	kernel_ulong_t driver_info;
};

#define CCW_DEVICE_ID_MATCH_CU_TYPE		0x01
#define CCW_DEVICE_ID_MATCH_CU_MODEL		0x02
#define CCW_DEVICE_ID_MATCH_DEVICE_TYPE		0x04
#define CCW_DEVICE_ID_MATCH_DEVICE_MODEL	0x08


#define PNP_ID_LEN	8
#define PNP_MAX_DEVICES	8

struct pnp_device_id {
	__u8 id[PNP_ID_LEN];
	kernel_ulong_t driver_data;
};

struct pnp_card_device_id {
	__u8 id[PNP_ID_LEN];
	kernel_ulong_t driver_data;
	struct {
		__u8 id[PNP_ID_LEN];
	} devs[PNP_MAX_DEVICES];
};


#endif /* LINUX_MOD_DEVICETABLE_H */

--0-360083758-1115155635=:93897--
