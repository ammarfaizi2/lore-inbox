Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318879AbSICTqb>; Tue, 3 Sep 2002 15:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSICTqb>; Tue, 3 Sep 2002 15:46:31 -0400
Received: from transport.cksoft.de ([62.111.66.27]:18193 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S318879AbSICTqY>; Tue, 3 Sep 2002 15:46:24 -0400
Date: Tue, 3 Sep 2002 21:50:27 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Subject: unresolved symbols in 2.5.33
Message-ID: <Pine.BSF.4.44.0209032138480.38285-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while debgging a 2.5.3x boot-up problem I downsized the kernel to a
minumum first and then started to add module support and modules ...

After simply enabling module support everything still worked ok.
So I added SCSI subsystem as modules and got ~250 lines of
unresolved symbols (see below).
If I add other modules, I am getting unresolved symbols for them too.

Are modules broken in 2.5.3x ?

bz@megablast:/usr/src/linux> grep PREEM .config
# CONFIG_PREEMPT is not set

Linux megablast 2.5.33 #2 SMP Tue Sep 3 17:14:12 UTC 2002 i686 unknown
depmod version 2.4.3
binutils-2.13.90.0.4
gcc version 3.2

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

--- snipp ---
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.33; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/aic7xxx/aic7xxx.o
depmod: 	pci_set_power_state
depmod: 	strsep
depmod: 	pci_register_driver
depmod: 	pci_bus_write_config_byte
depmod: 	__udelay
depmod: 	__release_region
depmod: 	vsprintf
depmod: 	pci_bus_read_config_dword
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	si_meminfo
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	__check_region
depmod: 	free_irq
depmod: 	panic
depmod: 	ioremap_nocache
depmod: 	iounmap
depmod: 	pci_alloc_consistent
depmod: 	del_timer
depmod: 	iomem_resource
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	unregister_reboot_notifier
depmod: 	request_irq
depmod: 	pci_bus_read_config_word
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	ioport_resource
depmod: 	pci_bus_write_config_dword
depmod: 	pci_bus_read_config_byte
depmod: 	__down_failed
depmod: 	register_reboot_notifier
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/scsi_mod.o
depmod: 	send_sig
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	blk_dump_rq_flags
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	kmem_cache_free
depmod: 	schedule
depmod: 	__release_region
depmod: 	blk_max_low_pfn
depmod: 	blk_cleanup_queue
depmod: 	generic_unplug_device
depmod: 	elv_next_request
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	kdevname
depmod: 	free_dma
depmod: 	end_that_request_last
depmod: 	blk_queue_max_sectors
depmod: 	__up_wakeup
depmod: 	open_softirq
depmod: 	blk_queue_max_hw_segments
depmod: 	create_proc_entry
depmod: 	blk_nohighio
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__get_free_pages
depmod: 	reparent_to_init
depmod: 	default_wake_function
depmod: 	cpu_raise_softirq
depmod: 	mempool_free
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	panic
depmod: 	mempool_alloc
depmod: 	end_that_request_first
depmod: 	blk_insert_request
depmod: 	elv_remove_request
depmod: 	free_pages
depmod: 	zone_table
depmod: 	add_blkdev_randomness
depmod: 	proc_mkdir
depmod: 	blk_rq_map_sg
depmod: 	kmem_cache_create
depmod: 	bus_register
depmod: 	strstr
depmod: 	del_timer
depmod: 	blk_queue_bounce_limit
depmod: 	kfree
depmod: 	device_create_file
depmod: 	wait_for_completion
depmod: 	remove_proc_entry
depmod: 	put_device
depmod: 	add_wait_queue
depmod: 	blk_init_queue
depmod: 	simple_strtoul
depmod: 	blk_queue_end_tag
depmod: 	sprintf
depmod: 	blk_queue_start_tag
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	daemonize
depmod: 	device_register
depmod: 	capable
depmod: 	jiffies
depmod: 	mempool_destroy
depmod: 	printk
depmod: 	add_timer
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	kmem_cache_alloc
depmod: 	blk_queue_max_phys_segments
depmod: 	__generic_copy_to_user
depmod: 	elv_queue_empty
depmod: 	mempool_create
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/sd_mod.o
depmod: 	schedule_timeout
depmod: 	register_disk
depmod: 	__write_lock_failed
depmod: 	check_disk_change
depmod: 	remove_driver
depmod: 	kmalloc
depmod: 	driverfs_remove_partitions
depmod: 	devfs_register_partitions
depmod: 	vfree
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	del_gendisk
depmod: 	blk_size
depmod: 	__read_lock_failed
depmod: 	add_gendisk
depmod: 	kfree
depmod: 	vmalloc
depmod: 	blk_dev
depmod: 	sprintf
depmod: 	blk_queue_hardsect_size
depmod: 	jiffies
depmod: 	printk
depmod: 	driver_register
depmod: 	wipe_partitions
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/sg.o
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	__write_lock_failed
depmod: 	generic_unplug_device
depmod: 	remove_driver
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	create_proc_entry
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	default_wake_function
depmod: 	__page_cache_release
depmod: 	remove_wait_queue
depmod: 	device_remove_file
depmod: 	free_pages
depmod: 	zone_table
depmod: 	__read_lock_failed
depmod: 	__pollwait
depmod: 	kfree
depmod: 	device_create_file
depmod: 	vmalloc
depmod: 	remove_proc_entry
depmod: 	rwsem_wake
depmod: 	kill_fasync
depmod: 	put_device
depmod: 	get_user_pages
depmod: 	fasync_helper
depmod: 	add_wait_queue
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	page_states
depmod: 	device_register
depmod: 	capable
depmod: 	jiffies
depmod: 	printk
depmod: 	driver_register
depmod: 	rwsem_down_read_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/sr_mod.o
depmod: 	blk_dump_rq_flags
depmod: 	cdrom_open
depmod: 	cdrom_release
depmod: 	register_cdrom
depmod: 	cdrom_ioctl
depmod: 	remove_driver
depmod: 	elv_next_request
depmod: 	kmalloc
depmod: 	invalidate_device
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	panic
depmod: 	cdrom_media_changed
depmod: 	unregister_cdrom
depmod: 	blk_size
depmod: 	kfree
depmod: 	device_create_file
depmod: 	blk_dev
depmod: 	cdrom_number_of_slots
depmod: 	sprintf
depmod: 	__invalidate_buffers
depmod: 	device_register
depmod: 	blk_queue_hardsect_size
depmod: 	printk
depmod: 	driver_register
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/drivers/scsi/st.o
depmod: 	schedule_timeout
depmod: 	__generic_copy_from_user
depmod: 	__write_lock_failed
depmod: 	blk_max_low_pfn
depmod: 	remove_driver
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	__page_cache_release
depmod: 	complete
depmod: 	panic
depmod: 	device_remove_file
depmod: 	zone_table
depmod: 	__read_lock_failed
depmod: 	kfree
depmod: 	device_create_file
depmod: 	wait_for_completion
depmod: 	rwsem_wake
depmod: 	put_device
depmod: 	get_user_pages
depmod: 	_alloc_pages
depmod: 	mem_map
depmod: 	sprintf
depmod: 	page_states
depmod: 	device_register
depmod: 	capable
depmod: 	__free_pages
depmod: 	printk
depmod: 	driver_register
depmod: 	rwsem_down_read_failed
depmod: 	__generic_copy_to_user
--- snipp ---

