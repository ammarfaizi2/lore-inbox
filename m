Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUIITMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUIITMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUIITKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:10:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61579 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266768AbUIITFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:05:23 -0400
Message-ID: <4140A970.5060408@vnet.ibm.com>
Date: Thu, 09 Sep 2004 14:05:20 -0500
From: will schmidt <will_schmidt@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: paulus@samba.org, anton@samba.org, willschm@us.ibm.com
Subject: [PATCH 2/2] PPC64 lparcfg Lindent whitespace and wordwrap cleanup.
Content-Type: multipart/mixed;
 boundary="------------080303020904080106080005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080303020904080106080005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch is the result of running Lindent against arch/ppc64/kernel/lparcfg.c.

This cleans up an assortment of whitespace and wordwrap inconsistencies.

Signed-off-by:  Will Schmidt   willschm@us.ibm.com

---

  lparcfg.c |  190 ++++++++++++++++++++++++++++++++------------------------------
  1 files changed, 99 insertions(+), 91 deletions(-)



--------------080303020904080106080005
Content-Type: text/plain;
 name="lparcfg.lindent.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lparcfg.lindent.diff"

--- a/arch/ppc64/kernel/lparcfg.c	2004-09-08 16:00:54.000000000 -0500
+++ b/arch/ppc64/krenel/lparcfg.c	2004-09-09 08:54:36.000000000 -0500
@@ -40,25 +40,31 @@
 /* #define LPARCFG_DEBUG */
 
 /* find a better place for this function... */
-void log_plpar_hcall_return(unsigned long rc,char * tag)
+void log_plpar_hcall_return(unsigned long rc, char *tag)
 {
-	if (rc ==0 ) /* success, return */
+	if (rc == 0)		/* success, return */
 		return;
 /* check for null tag ? */
 	if (rc == H_Hardware)
-		printk(KERN_INFO "plpar-hcall (%s) failed with hardware fault\n",tag);
+		printk(KERN_INFO
+		       "plpar-hcall (%s) failed with hardware fault\n", tag);
 	else if (rc == H_Function)
-		printk(KERN_INFO "plpar-hcall (%s) failed; function not allowed\n",tag);
+		printk(KERN_INFO
+		       "plpar-hcall (%s) failed; function not allowed\n", tag);
 	else if (rc == H_Authority)
-		printk(KERN_INFO "plpar-hcall (%s) failed; not authorized to this function\n",tag);
+		printk(KERN_INFO
+		       "plpar-hcall (%s) failed; not authorized to this function\n",
+		       tag);
 	else if (rc == H_Parameter)
-		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",tag);
+		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",
+		       tag);
 	else
-		printk(KERN_INFO "plpar-hcall (%s) failed with unexpected rc(0x%lx)\n",tag,rc);
+		printk(KERN_INFO
+		       "plpar-hcall (%s) failed with unexpected rc(0x%lx)\n",
+		       tag, rc);
 
 }
 
-
 static struct proc_dir_entry *proc_ppc64_lparcfg;
 #define LPARCFG_BUFF_SIZE 4096
 
@@ -78,59 +84,60 @@
 
 	shared = (int)(lpaca->lppaca_ptr->xSharedProc);
 	seq_printf(m, "serial_number=%c%c%c%c%c%c%c\n",
-		      e2a(xItExtVpdPanel.mfgID[2]),
-		      e2a(xItExtVpdPanel.mfgID[3]),
-		      e2a(xItExtVpdPanel.systemSerial[1]),
-		      e2a(xItExtVpdPanel.systemSerial[2]),
-		      e2a(xItExtVpdPanel.systemSerial[3]),
-		      e2a(xItExtVpdPanel.systemSerial[4]),
-		      e2a(xItExtVpdPanel.systemSerial[5])); 
+		   e2a(xItExtVpdPanel.mfgID[2]),
+		   e2a(xItExtVpdPanel.mfgID[3]),
+		   e2a(xItExtVpdPanel.systemSerial[1]),
+		   e2a(xItExtVpdPanel.systemSerial[2]),
+		   e2a(xItExtVpdPanel.systemSerial[3]),
+		   e2a(xItExtVpdPanel.systemSerial[4]),
+		   e2a(xItExtVpdPanel.systemSerial[5]));
 
 	seq_printf(m, "system_type=%c%c%c%c\n",
-		      e2a(xItExtVpdPanel.machineType[0]),
-		      e2a(xItExtVpdPanel.machineType[1]),
-		      e2a(xItExtVpdPanel.machineType[2]),
-		      e2a(xItExtVpdPanel.machineType[3])); 
+		   e2a(xItExtVpdPanel.machineType[0]),
+		   e2a(xItExtVpdPanel.machineType[1]),
+		   e2a(xItExtVpdPanel.machineType[2]),
+		   e2a(xItExtVpdPanel.machineType[3]));
 
-	lp_index = HvLpConfig_getLpIndex(); 
+	lp_index = HvLpConfig_getLpIndex();
 	seq_printf(m, "partition_id=%d\n", (int)lp_index);
 
 	seq_printf(m, "system_active_processors=%d\n",
-		      (int)HvLpConfig_getSystemPhysicalProcessors()); 
+		   (int)HvLpConfig_getSystemPhysicalProcessors());
 
 	seq_printf(m, "system_potential_processors=%d\n",
-		      (int)HvLpConfig_getSystemPhysicalProcessors()); 
+		   (int)HvLpConfig_getSystemPhysicalProcessors());
 
-	processors = (int)HvLpConfig_getPhysicalProcessors(); 
+	processors = (int)HvLpConfig_getPhysicalProcessors();
 	seq_printf(m, "partition_active_processors=%d\n", processors);
 
-	max_processors = (int)HvLpConfig_getMaxPhysicalProcessors(); 
+	max_processors = (int)HvLpConfig_getMaxPhysicalProcessors();
 	seq_printf(m, "partition_potential_processors=%d\n", max_processors);
 
-	if(shared) {
-		entitled_capacity = HvLpConfig_getSharedProcUnits(); 
-		max_entitled_capacity = HvLpConfig_getMaxSharedProcUnits(); 
+	if (shared) {
+		entitled_capacity = HvLpConfig_getSharedProcUnits();
+		max_entitled_capacity = HvLpConfig_getMaxSharedProcUnits();
 	} else {
-		entitled_capacity = processors * 100; 
-		max_entitled_capacity = max_processors * 100; 
+		entitled_capacity = processors * 100;
+		max_entitled_capacity = max_processors * 100;
 	}
 	seq_printf(m, "partition_entitled_capacity=%d\n", entitled_capacity);
 
 	seq_printf(m, "partition_max_entitled_capacity=%d\n",
-		      max_entitled_capacity);
+		   max_entitled_capacity);
 
-	if(shared) {
-		pool_id = HvLpConfig_getSharedPoolIndex(); 
+	if (shared) {
+		pool_id = HvLpConfig_getSharedPoolIndex();
 		seq_printf(m, "pool=%d\n", (int)pool_id);
 		seq_printf(m, "pool_capacity=%d\n",
-		    (int)(HvLpConfig_getNumProcsInSharedPool(pool_id)*100));
+			   (int)(HvLpConfig_getNumProcsInSharedPool(pool_id) *
+				 100));
 	}
 
 	seq_printf(m, "shared_processor_mode=%d\n", shared);
 
 	return 0;
 }
-#endif /* CONFIG_PPC_ISERIES */
+#endif				/* CONFIG_PPC_ISERIES */
 
 #ifdef CONFIG_PPC_PSERIES
 /* 
@@ -158,11 +165,13 @@
  *                  XXXX  - Processors active on platform. 
  */
 static unsigned int h_get_ppp(unsigned long *entitled,
-		unsigned long  *unallocated, unsigned long *aggregation,
-		unsigned long *resource)
+			      unsigned long *unallocated,
+			      unsigned long *aggregation,
+			      unsigned long *resource)
 {
 	unsigned long rc;
-	rc = plpar_hcall_4out(H_GET_PPP,0,0,0,0,entitled,unallocated,aggregation,resource);
+	rc = plpar_hcall_4out(H_GET_PPP, 0, 0, 0, 0, entitled, unallocated,
+			      aggregation, resource);
 
 	log_plpar_hcall_return(rc, "H_GET_PPP");
 
@@ -185,7 +194,7 @@
  */
 static unsigned long get_purr()
 {
-	unsigned long sum_purr=0;
+	unsigned long sum_purr = 0;
 	return sum_purr;
 }
 
@@ -202,7 +211,7 @@
 {
 	int call_status;
 
-	char * local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
+	char *local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
 	if (!local_buffer) {
 		printk(KERN_ERR "%s %s kmalloc failure at line %d \n",
 		       __FILE__, __FUNCTION__, __LINE__);
@@ -219,22 +228,23 @@
 	spin_unlock(&rtas_data_buf_lock);
 
 	if (call_status != 0) {
-		printk(KERN_INFO "%s %s Error calling get-system-parameter (0x%x)\n",
+		printk(KERN_INFO
+		       "%s %s Error calling get-system-parameter (0x%x)\n",
 		       __FILE__, __FUNCTION__, call_status);
 	} else {
 		int splpar_strlen;
 		int idx, w_idx;
-		char * workbuffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
+		char *workbuffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
 		if (!workbuffer) {
-			printk(KERN_ERR "%s %s kmalloc failure at line %d \n",__FILE__,__FUNCTION__,__LINE__);
+			printk(KERN_ERR "%s %s kmalloc failure at line %d \n",
+			       __FILE__, __FUNCTION__, __LINE__);
 			return;
 		}
-
 #ifdef LPARCFG_DEBUG
 		printk(KERN_INFO "success calling get-system-parameter \n");
 #endif
 		splpar_strlen = local_buffer[0] * 16 + local_buffer[1];
-		local_buffer += 2; /* step over strlen value */
+		local_buffer += 2;	/* step over strlen value */
 
 		memset(workbuffer, 0, SPLPAR_MAXLENGTH);
 		w_idx = 0;
@@ -253,13 +263,15 @@
 				w_idx = 0;
 			} else if (local_buffer[idx] == '=') {
 				/* code here to replace workbuffer contents
-				 with different keyword strings */
-				if (0 == strcmp(workbuffer,"MaxEntCap")) {
-					strcpy(workbuffer, "partition_max_entitled_capacity");
+				   with different keyword strings */
+				if (0 == strcmp(workbuffer, "MaxEntCap")) {
+					strcpy(workbuffer,
+					       "partition_max_entitled_capacity");
 					w_idx = strlen(workbuffer);
 				}
-				if (0 == strcmp(workbuffer,"MaxPlatProcs")) {
-					strcpy(workbuffer, "system_potential_processors");
+				if (0 == strcmp(workbuffer, "MaxPlatProcs")) {
+					strcpy(workbuffer,
+					       "system_potential_processors");
 					w_idx = strlen(workbuffer);
 				}
 			}
@@ -283,7 +295,7 @@
 
 	while ((cpus_dn = of_find_node_by_type(cpus_dn, "cpu"))) {
 #ifdef LPARCFG_DEBUG
-		printk(KERN_ERR "cpus_dn %p \n",cpus_dn);
+		printk(KERN_ERR "cpus_dn %p \n", cpus_dn);
 #endif
 		count++;
 	}
@@ -306,12 +318,11 @@
 		model = get_property(rootdn, "model", NULL);
 		system_id = get_property(rootdn, "system-id", NULL);
 		lp_index_ptr = (unsigned int *)
-			get_property(rootdn, "ibm,partition-no", NULL);
+		    get_property(rootdn, "ibm,partition-no", NULL);
 		if (lp_index_ptr)
 			lp_index = *lp_index_ptr;
 	}
 
-
 	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
 
 	seq_printf(m, "serial_number=%s\n", system_id);
@@ -350,14 +361,12 @@
 		/* this call handles the ibm,get-system-parameter contents */
 		parse_system_parameter_string(m);
 
-		seq_printf(m, "partition_entitled_capacity=%ld\n",
-			      h_entitled);
+		seq_printf(m, "partition_entitled_capacity=%ld\n", h_entitled);
 
-		seq_printf(m, "group=%ld\n",
-			      (h_aggregation >> 2*8) & 0xffff);
+		seq_printf(m, "group=%ld\n", (h_aggregation >> 2 * 8) & 0xffff);
 
 		seq_printf(m, "system_active_processors=%ld\n",
-			      (h_resource >> 0*8) & 0xffff);
+			   (h_resource >> 0 * 8) & 0xffff);
 
 		/* pool related entries are apropriate for shared configs */
 		if (paca[0].lppaca.xSharedProc) {
@@ -365,11 +374,11 @@
 			h_pic(&pool_idle_time, &pool_procs);
 
 			seq_printf(m, "pool=%ld\n",
-				   (h_aggregation >> 0*8) & 0xffff);
+				   (h_aggregation >> 0 * 8) & 0xffff);
 
 			/* report pool_capacity in percentage */
 			seq_printf(m, "pool_capacity=%ld\n",
-				   ((h_resource >> 2*8) & 0xffff)*100);
+				   ((h_resource >> 2 * 8) & 0xffff) * 100);
 
 			seq_printf(m, "pool_idle_time=%ld\n", pool_idle_time);
 
@@ -377,42 +386,39 @@
 		}
 
 		seq_printf(m, "unallocated_capacity_weight=%ld\n",
-			      (h_resource >> 4*8) & 0xFF);
+			   (h_resource >> 4 * 8) & 0xFF);
 
 		seq_printf(m, "capacity_weight=%ld\n",
-			      (h_resource >> 5*8) & 0xFF);
+			   (h_resource >> 5 * 8) & 0xFF);
+
+		seq_printf(m, "capped=%ld\n", (h_resource >> 6 * 8) & 0x01);
 
-		seq_printf(m, "capped=%ld\n",
-			      (h_resource >> 6*8) & 0x01);
+		seq_printf(m, "unallocated_capacity=%ld\n", h_unallocated);
 
-		seq_printf(m, "unallocated_capacity=%ld\n",
-			      h_unallocated);
+		seq_printf(m, "purr=%ld\n", purr);
 
-		seq_printf(m, "purr=%ld\n",
-			      purr);
+	} else {		/* non SPLPAR case */
 
-	} else /* non SPLPAR case */ {
 		seq_printf(m, "system_active_processors=%d\n",
-			      partition_potential_processors);
+			   partition_potential_processors);
 
 		seq_printf(m, "system_potential_processors=%d\n",
-			      partition_potential_processors);
+			   partition_potential_processors);
 
 		seq_printf(m, "partition_max_entitled_capacity=%d\n",
-			      partition_potential_processors * 100);
+			   partition_potential_processors * 100);
 
 		seq_printf(m, "partition_entitled_capacity=%d\n",
-			      partition_active_processors * 100);
+			   partition_active_processors * 100);
 	}
 
 	seq_printf(m, "partition_active_processors=%d\n",
-			      partition_active_processors);
+		   partition_active_processors);
 
 	seq_printf(m, "partition_potential_processors=%d\n",
-			      partition_potential_processors);
+		   partition_potential_processors);
 
-	seq_printf(m, "shared_processor_mode=%d\n",
-			paca[0].lppaca.xSharedProc);
+	seq_printf(m, "shared_processor_mode=%d\n", paca[0].lppaca.xSharedProc);
 
 	return 0;
 }
@@ -427,14 +433,15 @@
  * This function should be invoked only on systems with
  * FW_FEATURE_SPLPAR.
  */
-static ssize_t lparcfg_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
+static ssize_t lparcfg_write(struct file *file, const char __user * buf,
+			     size_t count, loff_t * off)
 {
 	char *kbuf;
 	char *tmp;
 	u64 new_entitled, *new_entitled_ptr = &new_entitled;
 	u8 new_weight, *new_weight_ptr = &new_weight;
 
-	unsigned long current_entitled;    /* parameters for h_get_ppp */
+	unsigned long current_entitled;	/* parameters for h_get_ppp */
 	unsigned long dummy;
 	unsigned long resource;
 	u8 current_weight;
@@ -459,13 +466,13 @@
 
 	if (!strcmp(kbuf, "partition_entitled_capacity")) {
 		char *endp;
-		*new_entitled_ptr = (u64)simple_strtoul(tmp, &endp, 10);
+		*new_entitled_ptr = (u64) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
 			goto out;
 		new_weight_ptr = &current_weight;
 	} else if (!strcmp(kbuf, "capacity_weight")) {
 		char *endp;
-		*new_weight_ptr = (u8)simple_strtoul(tmp, &endp, 10);
+		*new_weight_ptr = (u8) simple_strtoul(tmp, &endp, 10);
 		if (endp == tmp)
 			goto out;
 		new_entitled_ptr = &current_entitled;
@@ -479,7 +486,7 @@
 		goto out;
 	}
 
-	current_weight = (resource>>5*8)&0xFF;
+	current_weight = (resource >> 5 * 8) & 0xFF;
 
 	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
 		 __FUNCTION__, current_entitled, current_weight);
@@ -504,23 +511,23 @@
 		retval = -EIO;
 	}
 
-out:
+      out:
 	kfree(kbuf);
 	return retval;
 }
 
-#endif /* CONFIG_PPC_PSERIES */
+#endif				/* CONFIG_PPC_PSERIES */
 
-static int lparcfg_open(struct inode * inode, struct file * file)
+static int lparcfg_open(struct inode *inode, struct file *file)
 {
-	return single_open(file,lparcfg_data,NULL);
+	return single_open(file, lparcfg_data, NULL);
 }
 
 struct file_operations lparcfg_fops = {
-	owner:		THIS_MODULE,
-	read:		seq_read,
-	open:		lparcfg_open,
-	release:	single_release,
+      owner:THIS_MODULE,
+      read:seq_read,
+      open:lparcfg_open,
+      release:single_release,
 };
 
 int __init lparcfg_init(void)
@@ -539,7 +546,8 @@
 		ent->proc_fops = &lparcfg_fops;
 		ent->data = kmalloc(LPARCFG_BUFF_SIZE, GFP_KERNEL);
 		if (!ent->data) {
-			printk(KERN_ERR "Failed to allocate buffer for lparcfg\n");
+			printk(KERN_ERR
+			       "Failed to allocate buffer for lparcfg\n");
 			remove_proc_entry("lparcfg", ent->parent);
 			return -ENOMEM;
 		}
@@ -556,7 +564,7 @@
 {
 	if (proc_ppc64_lparcfg) {
 		if (proc_ppc64_lparcfg->data) {
-		    kfree(proc_ppc64_lparcfg->data);
+			kfree(proc_ppc64_lparcfg->data);
 		}
 		remove_proc_entry("lparcfg", proc_ppc64_lparcfg->parent);
 	}

--------------080303020904080106080005--
