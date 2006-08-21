Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWHUSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHUSvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWHUSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:51:01 -0400
Received: from server6.greatnet.de ([83.133.96.26]:6051 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750829AbWHUSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:50:42 -0400
Message-ID: <44EA0084.9030909@nachtwindheim.de>
Date: Mon, 21 Aug 2006 20:50:44 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: ipslinux@adaptec.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [DOC] ips.changelog 2/2 remove changelog from sourcefile
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Remove the changelog from the scsi ips driver, since there is and up-to-date
version of that changelog under Documentation/scsi/Changelog.ips.
I added a comment to mention that there is a changelog and where it exists.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.18-rc4/drivers/scsi/ips.c	2006-08-11 10:09:20.000000000 +0200
+++ linux/drivers/scsi/ips.c	2006-08-20 21:39:21.000000000 +0200
@@ -51,96 +51,7 @@
 /*                                                                           */
 /*****************************************************************************/
 
-/*****************************************************************************/
-/* Change Log                                                                */
-/*                                                                           */
-/* 0.99.02  - Breakup commands that are bigger than 8 * the stripe size      */
-/* 0.99.03  - Make interrupt routine handle all completed request on the     */
-/*            adapter not just the first one                                 */
-/*          - Make sure passthru commands get woken up if we run out of      */
-/*            SCBs                                                           */
-/*          - Send all of the commands on the queue at once rather than      */
-/*            one at a time since the card will support it.                  */
-/* 0.99.04  - Fix race condition in the passthru mechanism -- this required  */
-/*            the interface to the utilities to change                       */
-/*          - Fix error recovery code                                        */
-/* 0.99.05  - Fix an oops when we get certain passthru commands              */
-/* 1.00.00  - Initial Public Release                                         */
-/*            Functionally equivalent to 0.99.05                             */
-/* 3.60.00  - Bump max commands to 128 for use with firmware 3.60            */
-/*          - Change version to 3.60 to coincide with release numbering.     */
-/* 3.60.01  - Remove bogus error check in passthru routine                   */
-/* 3.60.02  - Make DCDB direction based on lookup table                      */
-/*          - Only allow one DCDB command to a SCSI ID at a time             */
-/* 4.00.00  - Add support for ServeRAID 4                                    */
-/* 4.00.01  - Add support for First Failure Data Capture                     */
-/* 4.00.02  - Fix problem with PT DCDB with no buffer                        */
-/* 4.00.03  - Add alternative passthru interface                             */
-/*          - Add ability to flash BIOS                                      */
-/* 4.00.04  - Rename structures/constants to be prefixed with IPS_           */
-/* 4.00.05  - Remove wish_block from init routine                            */
-/*          - Use linux/spinlock.h instead of asm/spinlock.h for kernels     */
-/*            2.3.18 and later                                               */
-/*          - Sync with other changes from the 2.3 kernels                   */
-/* 4.00.06  - Fix timeout with initial FFDC command                          */
-/* 4.00.06a - Port to 2.4 (trivial) -- Christoph Hellwig <hch@infradead.org> */
-/* 4.10.00  - Add support for ServeRAID 4M/4L                                */
-/* 4.10.13  - Fix for dynamic unload and proc file system                    */
-/* 4.20.03  - Rename version to coincide with new release schedules          */
-/*            Performance fixes                                              */
-/*            Fix truncation of /proc files with cat                         */
-/*            Merge in changes through kernel 2.4.0test1ac21                 */
-/* 4.20.13  - Fix some failure cases / reset code                            */
-/*          - Hook into the reboot_notifier to flush the controller cache    */
-/* 4.50.01  - Fix problem when there is a hole in logical drive numbering    */
-/* 4.70.09  - Use a Common ( Large Buffer ) for Flashing from the JCRM CD    */
-/*          - Add IPSSEND Flash Support                                      */
-/*          - Set Sense Data for Unknown SCSI Command                        */
-/*          - Use Slot Number from NVRAM Page 5                              */
-/*          - Restore caller's DCDB Structure                                */
-/* 4.70.12  - Corrective actions for bad controller ( during initialization )*/
-/* 4.70.13  - Don't Send CDB's if we already know the device is not present  */
-/*          - Don't release HA Lock in ips_next() until SC taken off queue   */
-/*          - Unregister SCSI device in ips_release()                        */
-/* 4.70.15  - Fix Breakup for very large ( non-SG ) requests in ips_done()   */
-/* 4.71.00  - Change all memory allocations to not use GFP_DMA flag          */
-/*            Code Clean-Up for 2.4.x kernel                                 */
-/* 4.72.00  - Allow for a Scatter-Gather Element to exceed MAX_XFER Size     */
-/* 4.72.01  - I/O Mapped Memory release ( so "insmod ips" does not Fail )    */
-/*          - Don't Issue Internal FFDC Command if there are Active Commands */
-/*          - Close Window for getting too many IOCTL's active               */
-/* 4.80.00  - Make ia64 Safe                                                 */
-/* 4.80.04  - Eliminate calls to strtok() if 2.4.x or greater                */
-/*          - Adjustments to Device Queue Depth                              */
-/* 4.80.14  - Take all semaphores off stack                                  */
-/*          - Clean Up New_IOCTL path                                        */
-/* 4.80.20  - Set max_sectors in Scsi_Host structure ( if >= 2.4.7 kernel )  */
-/*          - 5 second delay needed after resetting an i960 adapter          */
-/* 4.80.26  - Clean up potential code problems ( Arjan's recommendations )   */
-/* 4.90.01  - Version Matching for FirmWare, BIOS, and Driver                */
-/* 4.90.05  - Use New PCI Architecture to facilitate Hot Plug Development    */
-/* 4.90.08  - Increase Delays in Flashing ( Trombone Only - 4H )             */
-/* 4.90.08  - Data Corruption if First Scatter Gather Element is > 64K       */
-/* 4.90.11  - Don't actually RESET unless it's physically required           */
-/*          - Remove unused compile options                                  */
-/* 5.00.01  - Sarasota ( 5i ) adapters must always be scanned first          */
-/*          - Get rid on IOCTL_NEW_COMMAND code                              */
-/*          - Add Extended DCDB Commands for Tape Support in 5I              */
-/* 5.10.12  - use pci_dma interfaces, update for 2.5 kernel changes          */
-/* 5.10.15  - remove unused code (sem, macros, etc.)                         */
-/* 5.30.00  - use __devexit_p()                                              */
-/* 6.00.00  - Add 6x Adapters and Battery Flash                              */
-/* 6.10.00  - Remove 1G Addressing Limitations                               */
-/* 6.11.xx  - Get VersionInfo buffer off the stack !              DDTS 60401 */
-/* 6.11.xx  - Make Logical Drive Info structure safe for DMA      DDTS 60639 */
-/* 7.10.18  - Add highmem_io flag in SCSI Templete for 2.4 kernels           */
-/*          - Fix path/name for scsi_hosts.h include for 2.6 kernels         */
-/*          - Fix sort order of 7k                                           */
-/*          - Remove 3 unused "inline" functions                             */
-/* 7.12.xx  - Use STATIC functions whereever possible                        */
-/*          - Clean up deprecated MODULE_PARM calls                          */
-/* 7.12.05  - Remove Version Matching per IBM request                        */
-/*****************************************************************************/
+/* ChangeLog is available under Documentation/scsi/Changelog.ips */
 
 /*
  * Conditional Compilation directives for this driver:


