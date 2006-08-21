Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWHUSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWHUSvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHUSul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:50:41 -0400
Received: from server6.greatnet.de ([83.133.96.26]:18082 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750802AbWHUSu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:50:29 -0400
Message-ID: <44EA0077.3030205@nachtwindheim.de>
Date: Mon, 21 Aug 2006 20:50:31 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: ipslinux@adaptec.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] [DOC] ips.changelog 1/2 update and cleanup
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Brings the changelog of the scsi ips.c up-to-date and replaces
whitespaces with tabs.
old filesize: 5304 Bytes
new filesize: 4774 Bytes
Signed-off-by: Henrik Kretzschmar <henne@achtwindheim.de>
---

--- linux-2.6.18-rc4/Documentation/scsi/ChangeLog.ips	2006-06-18 03:49:35.000000000 +0200
+++ linux/Documentation/scsi/ChangeLog.ips	2006-08-20 21:27:22.000000000 +0200
@@ -1,122 +1,141 @@
 IBM ServeRAID driver Change Log
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+	7.12.05	- remove version matching per IBM request
 
-        5.00.01  - Sarasota ( 5i ) adapters must always be scanned first  
-                 - Get rid on IOCTL_NEW_COMMAND code  
-                 - Add Extended DCDB Commands for Tape Support in 5I                  
-        
-        4.90.11  - Don't actually RESET unless it's physically required
-                 - Remove unused compile options
-        
-        4.90.08  - Data Corruption if First Scatter Gather Element is > 64K
-        
-        4.90.08  - Increase Delays in Flashing ( Trombone Only - 4H )        
-        
-        4.90.05  - Use New PCI Architecture to facilitate Hot Plug Development
-        
-        4.90.01  - Add ServeRAID Version Checking
-
-        4.80.26  - Clean up potential code problems ( Arjan's recommendations )
-        
-        4.80.21  - Change memcpy() to copy_to_user() in NVRAM Page 5 IOCTL path   
-        
-        4.80.20  - Set max_sectors in Scsi_Host structure ( if >= 2.4.7 kernel )
-                 - 5 second delay needed after resetting an i960 adapter
-        
-        4.80.14  - Take all semaphores off stack                    
-                 - Clean Up New_IOCTL path
-                   
-        4.80.04  - Eliminate calls to strtok() if 2.4.x or greater 
-                 - Adjustments to Device Queue Depth               
-
-        4.80.00  - Make ia64 Safe    
-        
-        4.72.01  - I/O Mapped Memory release ( so "insmod ips" does not Fail )    
-                 - Don't Issue Internal FFDC Command if there are Active Commands 
-                 - Close Window for getting too many IOCTL's active 
-                   
-        4.72.00  - Allow for a Scatter-Gather Element to exceed MAX_XFER Size     
-        
-        4.71.00  - Change all memory allocations to not use GFP_DMA flag 
-                 - Code Clean-Up for 2.4.x kernel      
-        
-        4.70.15  - Fix Breakup for very large ( non-SG ) requests
-        
-        4.70.13  - Don't release HA Lock in ips_next() until SC taken off queue  
-                 - Unregister SCSI device in ips_release()                        
-                 - Don't Send CDB's if we already know the device is not present  
-                 
-        4.70.12  - Corrective actions for bad controller ( during initialization )
-        
-        4.70.09  - Use a Common ( Large Buffer ) for Flashing from the JCRM CD    
-                 - Add IPSSEND Flash Support                                      
-                 - Set Sense Data for Unknown SCSI Command                        
-                 - Use Slot Number from NVRAM Page 5 
-                 - Restore caller's DCDB Structure
-                                       
-        4.20.14  - Update patch files for kernel 2.4.0-test5
-
-        4.20.13  - Fix some failure cases / reset code
-                 - Hook into the reboot_notifier to flush the controller
-                   cache
-
-        4.20.03 - Rename version to coincide with new release schedules
-                - Performance fixes
-                - Fix truncation of /proc files with cat
-                - Merge in changes through kernel 2.4.0test1ac21
-
-        4.10.13 - Fix for dynamic unload and proc file system
-
-        4.10.00 - Add support for ServeRAID 4M/4L
-
-        4.00.06 - Fix timeout with initial FFDC command
-
-        4.00.05 - Remove wish_block from init routine
-                - Use linux/spinlock.h instead of asm/spinlock.h for kernels
-                  2.3.18 and later
-                - Sync with other changes from the 2.3 kernels
-
-        4.00.04 - Rename structures/constants to be prefixed with IPS_
-
-        4.00.03 - Add alternative passthru interface
-                - Add ability to flash ServeRAID BIOS
-
-        4.00.02 - Fix problem with PT DCDB with no buffer
-
-        4.00.01 - Add support for First Failure Data Capture
-
-        4.00.00 - Add support for ServeRAID 4
-
-        3.60.02 - Make DCDB direction based on lookup table.
-                - Only allow one DCDB command to a SCSI ID at a time.
-
-        3.60.01 - Remove bogus error check in passthru routine.
-
-        3.60.00 - Bump max commands to 128 for use with ServeRAID
-                  firmware 3.60.
-                - Change version to 3.60 to coincide with ServeRAID release
+	7.12.xx	- use STATIC functions whereever possible
+		- clean up deprecated MODULE_PARM calls
+
+	7.10.18	- add highmem_io flag in SCSI template for 2.4 kernels
+		- fix path/name for scsi_hosts.h include for 2.6 kernels
+		- fix sort order of 7k
+		- remove 3 unused inline functions
+
+	6.11.xx	- make logicial drive info structure safe for DMA DDTS 60639
+
+	6.11.xx	- get VersionInfo buffer off the stack! DDTS 60401
+
+	6.10.00	- remove 1G addressing limitations
+
+	6.00.00	- add 6x adapters and battery flash
+
+	5.30.00	- use devexit_p()
+
+	5.10.15	- remove unused code (sem, macros, etc.)
+
+	5.10.12	- use pci_dma interface, update for 2.5 kernel changes
+
+	5.00.01	- Sarasota ( 5i ) adapters must always be scanned first  
+		- Get rid on IOCTL_NEW_COMMAND code
+		- Add Extended DCDB Commands for Tape Support in 5I
+
+	4.90.11	- Don't actually RESET unless it's physically required
+		- Remove unused compile options
+
+	4.90.08	- Data Corruption if First Scatter Gather Element is > 64K
+
+	4.90.08	- Increase Delays in Flashing ( Trombone Only - 4H )
+
+	4.90.05	- Use New PCI Architecture to facilitate Hot Plug Development
+
+	4.90.01	- Add ServeRAID Version Checking
+
+	4.80.26	- Clean up potential code problems ( Arjan's recommendations )
+
+	4.80.21	- Change memcpy() to copy_to_user() in NVRAM Page 5 IOCTL path
+
+	4.80.20	- Set max_sectors in Scsi_Host structure ( if >= 2.4.7 kernel )
+		- 5 second delay needed after resetting an i960 adapter
+
+	4.80.14	- Take all semaphores off stack
+		- Clean Up New_IOCTL path
+
+	4.80.04	- Eliminate calls to strtok() if 2.4.x or greater
+		- Adjustments to Device Queue Depth
+
+	4.80.00	- Make ia64 Safe
+
+	4.72.01	- I/O Mapped Memory release ( so "insmod ips" does not Fail )
+		- Don't Issue Internal FFDC Command if there are Active	Commands
+		- Close Window for getting too many IOCTL's active
+
+	4.72.00	- Allow for a Scatter-Gather Element to exceed MAX_XFER Size
+
+	4.71.00	- Change all memory allocations to not use GFP_DMA flag
+		- Code Clean-Up for 2.4.x kernel
+
+	4.70.15	- Fix Breakup for very large ( non-SG ) requests
+
+	4.70.13	- Don't release HA Lock in ips_next() until SC taken off queue
+		- Unregister SCSI device in ips_release()
+		- Don't Send CDB's if we already know the device is not present
+
+	4.70.12	- Corrective actions for bad controller (during initialization)
+
+	4.70.09	- Use a Common (Large Buffer) for Flashing from the JCRM CD
+		- Add IPSSEND Flash Support
+		- Set Sense Data for Unknown SCSI Command
+		- Use Slot Number from NVRAM Page 5
+		- Restore caller's DCDB Structure
+
+	4.20.14	- Update patch files for kernel 2.4.0-test5
+
+	4.20.13	- Fix some failure cases / reset code
+		- Hook into the reboot_notifier to flush the controller cache
+
+	4.20.03	- Rename version to coincide with new release schedules
+		- Performance fixes
+		- Fix truncation of /proc files with cat
+		- Merge in changes through kernel 2.4.0test1ac21
+
+	4.10.13	- Fix for dynamic unload and proc file system
+
+	4.10.00	- Add support for ServeRAID 4M/4L
+
+	4.00.06	- Fix timeout with initial FFDC command
+
+	4.00.05	- Remove wish_block from init routine
+		- Use linux/spinlock.h instead of asm/spinlock.h for kernels
+		  2.3.18 and later
+		- Sync with other changes from the 2.3 kernels
+
+	4.00.04	- Rename structures/constants to be prefixed with IPS_
+
+	4.00.03	- Add alternative passthru interface
+		- Add ability to flash ServeRAID BIOS
+
+	4.00.02	- Fix problem with PT DCDB with no buffer
+
+	4.00.01	- Add support for First Failure Data Capture
+
+	4.00.00	- Add support for ServeRAID 4
+
+	3.60.02	- Make DCDB direction based on lookup table.
+		- Only allow one DCDB command to a SCSI ID at a time.
+
+	3.60.01	- Remove bogus error check in passthru routine.
+
+	3.60.00	- Bump max commands to 128 for use with ServeRAID firmware 3.60.
+		- Change version to 3.60 to coincide with ServeRAID release
                   numbering.
 
-        1.00.00 - Initial Public Release
-                - Functionally equivalent to 0.99.05
+	1.00.00	- Initial Public Release
+		- Functionally equivalent to 0.99.05
 
-        0.99.05 - Fix an oops on certain passthru commands
+	0.99.05	- Fix an oops on certain passthru commands
 
-        0.99.04 - Fix race condition in the passthru mechanism
-                  -- this required the interface to the utilities to change
-                - Fix error recovery code
-
-        0.99.03 - Make interrupt routine handle all completed request on the
-                  adapter not just the first one
-                - Make sure passthru commands get woken up if we run out of
-                  SCBs
-                - Send all of the commands on the queue at once rather than
+	0.99.04	- Fix race condition in the passthru mechanism -- this required
+		  the interface to the utilities to change
+		- Fix error recovery code
+
+	0.99.03	- Make interrupt routine handle all completed request on the
+		  adapter not just the first one
+		- Make sure passthru commands get woken up if we run out of SCBs
+		- Send all of the commands on the queue at once rather than
                   one at a time since the card will support it.
 
-        0.99.02 - Added some additional debug statements to print out
-                  errors if an error occurs while trying to read/write
-                  to a logical drive (IPS_DEBUG).
+	0.99.02	- Added some additional debug statements to print out
+		  errors if an error occurs while trying to read/write
+		  to a logical drive (IPS_DEBUG).
 
-                - Fixed read/write errors when the adapter is using an
+		- Fixed read/write errors when the adapter is using an
                   8K stripe size.
-


