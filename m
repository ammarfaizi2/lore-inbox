Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVDNRPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVDNRPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDNRPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:15:33 -0400
Received: from mail4.utc.com ([192.249.46.193]:50890 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S261560AbVDNRNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:13:22 -0400
Message-ID: <425EA4A8.6040106@cybsft.com>
Date: Thu, 14 Apr 2005 12:13:12 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Duffy <tduffy@sun.com>
CC: James.Smart@Emulex.Com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Heads up on 2.6.12-rc1 and later
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AB9C@xbl3.ad.emulex.com> <1113497691.13402.4.camel@duffman>
In-Reply-To: <1113497691.13402.4.camel@duffman>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Duffy wrote:
> On Thu, 2005-04-14 at 12:29 -0400, James.Smart@Emulex.Com wrote:
> 
>>In testing with 2.6.12-rc1 and -rc2, we've been encountering an issue
>>on SMP machines with the loading of scsi_mod and sd_mod modules. The
>>sd_mod load fails with unresolved symbols. It appears to be a race
>>condition based on how quickly the modules load. This works fine on
>>uni systems and on 2.6.11.
>>
>>Evidently, this problem has been before and is resolved by a short
>>delay between module loads.
>>http://seclists.org/lists/linux-kernel/2005/Apr/0383.html

BTW. I haven't had time to debug this any further myself, but for me 
adding a one second delay between module loads DOES NOT WORK for me.

>>
>>Given it's been around for 2 -rc itterations, I expect it needed some
>>highlighting.
> 
> 
> Ah, so it is not just me (thought I was going crazy -- couldn't get a
> kernel to boot on my SMP system):
> 
> Mounting sysfs
> Creating /dev
> Starting udev
> Loading scsi_modSCSI subsystem initialized
> .ko module
> LoadFusion MPT base driver 3.01.20
> ing sd_mod.ko momptscsih: Unknown symbol mpt_deregister
> mptscsih: Unknown symbol mpt_reset_deregister
> mptscsih: Unknown symbol mpt_config
> mptscsih: Unknown symbol mpt_device_driver_deregister
> mptscsih: Unknown symbol mpt_free_msg_frame
> mptscsih: Unknown symbol scsi_remove_host
> mptscsih: Unknown symbol mpt_print_ioc_summary
> mptscsih: Unknown symbol mpt_GetIocState
> mptscsih: Unknown symbol mpt_put_msg_frame
> mptscsih: Unknown symbol mpt_register
> mptscsih: Unknown symbol mpt_add_sge
> mptscsih: Unknown symbol mpt_event_deregister
> mptscsih: Unknown symbol scsi_host_put
> mptscsih: Unknown symbol mpt_read_ioc_pg_3
> mptscsih: Unknown symbol scsi_scan_host
> mptscsih: Unknown symbol mpt_event_register
> mptscsih: Unknown symbol mpt_send_handshake_request
> mptscsih: Unknown symbol scsi_add_host
> mptscsih: Unknown symbol mpt_device_driver_register
> mptscsih: Unknown symbol scsi_adjust_queue_depth
> mptscsih: Unknown symbol mpt_get_msg_frame
> mptscsih: Unknown symbol mpt_reset_register
> mptscsih: Unknown symbol mpt_HardResetHandler
> mptscsih: Unknown symbol scsi_host_alloc
> mptscsih: Unknown symbol ioc_list
> dule
> Loading mpinput: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> sd_mod: Unknown symbol scsi_device_get
> sd_mod: Unknown symbol scsi_wait_req
> sd_mod: Unknown symbol scsi_get_sense_info_fld
> sd_mod: Unknown symbol scsicam_bios_param
> sd_mod: Unknown symbol scsi_command_normalize_sense
> sd_mod: Unknown symbol scsi_test_unit_ready
> sd_mod: Unknown symbol scsi_block_when_processing_errors
> sd_mod: Unknown symbol scsi_register_driver
> sd_mod: Unknown symbol scsi_ioctl
> sd_mod: Unknown symbol scsi_nonblockable_ioctl
> sd_mod: Unknown symbol scsi_device_put
> sd_mod: Unknown symbol scsi_request_normalize_sense
> sd_mod: Unknown symbol __scsi_mode_sense
> sd_mod: Unknown symbol scsi_logging_level
> sd_mod: Unknown symbol scsi_print_req_sense
> sd_mod: Unknown symbol scsi_release_request
> sd_mod: Unknown symbol scsi_print_sense
> sd_mod: Unknown symbol scsi_allocate_request
> sd_mod: Unknown symbol scsi_io_completion
> sd_mod: Unknown symbol scsi_set_medium_removal
> 
> Loading mptscsiCopyright (c) 1999-2004 LSI Logic Corporation
> h.ko module
> LoaACPI: PCI Interrupt 0000:05:05.0[A] -> ding dm-mod.ko mGSI 72 (level,
> low) -> IRQ 185
> odule
> Loading jmptbase: Initiating ioc0 bringup
> bd.ko module
> Lodevice-mapper: 4.4.0-ioctl (2005-01-12) initialised:
> dm-devel@redhat.com
> ading ext3.ko moext3: Unknown symbol journal_force_commit
> dule
> insmod: erext3: Unknown symbol journal_dirty_data
> ror inserting '/<ex0>tK3e:r Unenkl npowann iscy -m bonlo t
> jsouynrncailn_gf: oArctete_mcopmtemdit t_no eskitledl
> iniext!t3
>   Unknown symbol journal_init_dev
> 


-- 
    kr
