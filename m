Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUBIXbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUBIX3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:29:17 -0500
Received: from mail.kroah.org ([65.200.24.183]:445 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265442AbUBIXWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:44 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689381685@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:18 -0800
Message-Id: <10763689383236@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.7, 2004/02/02 11:42:37-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Whitespace fixes for acpiphp

This are some whitespace fixes for acpiphp, in most cases killing spaces
before the opening brace of function declarations.


 drivers/pci/hotplug/acpiphp_glue.c |   50 ++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 25 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Mon Feb  9 14:59:22 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Mon Feb  9 14:59:22 2004
@@ -87,7 +87,7 @@
 
 /* callback routine to check the existence of ejectable slots */
 static acpi_status
-is_ejectable_slot (acpi_handle handle, u32 lvl,	void *context, void **rv)
+is_ejectable_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	int *count = (int *)context;
 
@@ -103,7 +103,7 @@
 
 /* callback routine to register each ACPI PCI slot object */
 static acpi_status
-register_slot (acpi_handle handle, u32 lvl, void *context, void **rv)
+register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *)context;
 	struct acpiphp_slot *slot;
@@ -212,7 +212,7 @@
 
 
 /* see if it's worth looking at this bridge */
-static int detect_ejectable_slots (acpi_handle *bridge_handle)
+static int detect_ejectable_slots(acpi_handle *bridge_handle)
 {
 	acpi_status status;
 	int count;
@@ -231,7 +231,7 @@
  * TBD: _TRA, etc.
  */
 static acpi_status
-decode_acpi_resource (struct acpi_resource *resource, void *context)
+decode_acpi_resource(struct acpi_resource *resource, void *context)
 {
 	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *) context;
 	struct acpi_resource_address64 address;
@@ -339,7 +339,7 @@
 
 
 /* initialize miscellaneous stuff for both root and PCI-to-PCI bridge */
-static void init_bridge_misc (struct acpiphp_bridge *bridge)
+static void init_bridge_misc(struct acpiphp_bridge *bridge)
 {
 	acpi_status status;
 
@@ -371,7 +371,7 @@
 
 
 /* allocate and initialize host bridge data structure */
-static void add_host_bridge (acpi_handle *handle, int seg, int bus)
+static void add_host_bridge(acpi_handle *handle, int seg, int bus)
 {
 	acpi_status status;
 	struct acpiphp_bridge *bridge;
@@ -423,7 +423,7 @@
 
 
 /* allocate and initialize PCI-to-PCI bridge data structure */
-static void add_p2p_bridge (acpi_handle *handle, int seg, int bus, int dev, int fn)
+static void add_p2p_bridge(acpi_handle *handle, int seg, int bus, int dev, int fn)
 {
 	struct acpiphp_bridge *bridge;
 	u8 tmp8;
@@ -573,7 +573,7 @@
 
 /* callback routine to find P2P bridges */
 static acpi_status
-find_p2p_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
+find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
 	acpi_handle dummy_handle;
@@ -673,13 +673,13 @@
 }
 
 
-static void remove_bridge (acpi_handle handle)
+static void remove_bridge(acpi_handle handle)
 {
 	/* No-op for now .. */
 }
 
 
-static int power_on_slot (struct acpiphp_slot *slot)
+static int power_on_slot(struct acpiphp_slot *slot)
 {
 	acpi_status status;
 	struct acpiphp_func *func;
@@ -714,7 +714,7 @@
 }
 
 
-static int power_off_slot (struct acpiphp_slot *slot)
+static int power_off_slot(struct acpiphp_slot *slot)
 {
 	acpi_status status;
 	struct acpiphp_func *func;
@@ -778,7 +778,7 @@
  * not per each slot object in ACPI namespace.
  *
  */
-static int enable_device (struct acpiphp_slot *slot)
+static int enable_device(struct acpiphp_slot *slot)
 {
 	u8 bus;
 	struct pci_dev *dev;
@@ -852,7 +852,7 @@
 /**
  * disable_device - disable a slot
  */
-static int disable_device (struct acpiphp_slot *slot)
+static int disable_device(struct acpiphp_slot *slot)
 {
 	int retval = 0;
 	struct acpiphp_func *func;
@@ -894,7 +894,7 @@
  *
  * otherwise return 0
  */
-static unsigned int get_slot_status (struct acpiphp_slot *slot)
+static unsigned int get_slot_status(struct acpiphp_slot *slot)
 {
 	acpi_status status;
 	unsigned long sta = 0;
@@ -939,7 +939,7 @@
  * handles ACPI event notification on {host,p2p} bridges
  *
  */
-static void handle_hotplug_event_bridge (acpi_handle handle, u32 type, void *context)
+static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *context)
 {
 	struct acpiphp_bridge *bridge;
 	char objname[64];
@@ -1005,7 +1005,7 @@
  * handles ACPI event notification on slots
  *
  */
-static void handle_hotplug_event_func (acpi_handle handle, u32 type, void *context)
+static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
 {
 	struct acpiphp_func *func;
 	char objname[64];
@@ -1171,7 +1171,7 @@
 
 
 /* search matching slot from id  */
-struct acpiphp_slot *get_slot_from_id (int id)
+struct acpiphp_slot *get_slot_from_id(int id)
 {
 	struct list_head *node;
 	struct acpiphp_bridge *bridge;
@@ -1193,7 +1193,7 @@
 /**
  * acpiphp_enable_slot - power on slot
  */
-int acpiphp_enable_slot (struct acpiphp_slot *slot)
+int acpiphp_enable_slot(struct acpiphp_slot *slot)
 {
 	int retval;
 
@@ -1217,7 +1217,7 @@
 /**
  * acpiphp_disable_slot - power off slot
  */
-int acpiphp_disable_slot (struct acpiphp_slot *slot)
+int acpiphp_disable_slot(struct acpiphp_slot *slot)
 {
 	int retval = 0;
 
@@ -1249,7 +1249,7 @@
 /**
  * acpiphp_check_bridge - re-enumerate devices
  */
-int acpiphp_check_bridge (struct acpiphp_bridge *bridge)
+int acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 {
 	struct acpiphp_slot *slot;
 	unsigned int sta;
@@ -1296,7 +1296,7 @@
  * slot enabled:  1
  * slot disabled: 0
  */
-u8 acpiphp_get_power_status (struct acpiphp_slot *slot)
+u8 acpiphp_get_power_status(struct acpiphp_slot *slot)
 {
 	unsigned int sta;
 
@@ -1314,7 +1314,7 @@
  * no direct attention led status information via ACPI
  *
  */
-u8 acpiphp_get_attention_status (struct acpiphp_slot *slot)
+u8 acpiphp_get_attention_status(struct acpiphp_slot *slot)
 {
 	return 0;
 }
@@ -1324,7 +1324,7 @@
  * latch closed:  1
  * latch   open:  0
  */
-u8 acpiphp_get_latch_status (struct acpiphp_slot *slot)
+u8 acpiphp_get_latch_status(struct acpiphp_slot *slot)
 {
 	unsigned int sta;
 
@@ -1338,7 +1338,7 @@
  * adapter presence : 1
  *          absence : 0
  */
-u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot)
+u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot)
 {
 	unsigned int sta;
 
@@ -1351,7 +1351,7 @@
 /*
  * pci address (seg/bus/dev)
  */
-u32 acpiphp_get_address (struct acpiphp_slot *slot)
+u32 acpiphp_get_address(struct acpiphp_slot *slot)
 {
 	u32 address;
 

