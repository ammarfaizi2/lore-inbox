Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTLQL51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLQL51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:57:27 -0500
Received: from main.gmane.org ([80.91.224.249]:6378 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264362AbTLQL5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:57:24 -0500
Mail-Followup-To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (=?utf-8?b?RGFnZmlubiBJbG1hcmkg?=
	=?utf-8?b?TWFubnPDpWtlcg==?=)
Subject: UP build broken (Re: 2.6.0-test11-mm1)
Date: Wed, 17 Dec 2003 12:57:21 +0100
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8j1xr34py6.fsf@wirth.ping.uio.no>
References: <20031217014350.028460b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Mail-Copies-To: nobody
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:fTU85laq93KWQ1Fm4Slp9vL6LzM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Without CONFIG_SMP (regardless of CONFIG_X86_UP_(IO)APIC) I get the
following build error:

  CC      arch/i386/kernel/cpu/intel.o
In file included from arch/i386/kernel/cpu/intel.c:14:
include/asm-i386/mach-default/mach_apic.h:8: error: syntax error before "target_cpus"
include/asm-i386/mach-default/mach_apic.h:9: warning: return type defaults to `int'
include/asm-i386/mach-default/mach_apic.h: In function `target_cpus':
include/asm-i386/mach-default/mach_apic.h:13: warning: implicit declaration of function `mk_cpumask_const'
include/asm-i386/mach-default/mach_apic.h:13: warning: implicit declaration of function `cpumask_of_cpu'
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:32: error: syntax error before "bitmap"
include/asm-i386/mach-default/mach_apic.h:33: warning: function declaration isn't a prototype
include/asm-i386/mach-default/mach_apic.h: In function `check_apicid_used':
include/asm-i386/mach-default/mach_apic.h:34: warning: implicit declaration of function `physid_isset'
include/asm-i386/mach-default/mach_apic.h:34: error: `apicid' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:34: error: (Each undeclared identifier is reported only once
include/asm-i386/mach-default/mach_apic.h:34: error: for each function it appears in.)
include/asm-i386/mach-default/mach_apic.h:34: error: `bitmap' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: In function `check_apicid_present':
include/asm-i386/mach-default/mach_apic.h:39: error: `phys_cpu_present_map' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: In function `init_apic_ldr':
include/asm-i386/mach-default/mach_apic.h:53: warning: implicit declaration of function `apic_write_around'
include/asm-i386/mach-default/mach_apic.h:53: error: `APIC_DFR' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:53: error: `APIC_DFR_FLAT' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:54: warning: implicit declaration of function `apic_read'
include/asm-i386/mach-default/mach_apic.h:54: error: `APIC_LDR' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:54: error: `APIC_LDR_MASK' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:55: warning: implicit declaration of function `SET_APIC_LOGICAL_ID'
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:59: error: syntax error before "ioapic_phys_id_map"
include/asm-i386/mach-default/mach_apic.h:59: error: syntax error before "phys_map"
include/asm-i386/mach-default/mach_apic.h:60: warning: return type defaults to `int'
include/asm-i386/mach-default/mach_apic.h:60: warning: function declaration isn't a prototype
include/asm-i386/mach-default/mach_apic.h: In function `ioapic_phys_id_map':
include/asm-i386/mach-default/mach_apic.h:61: error: `phys_map' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: In function `clustered_apic_check':
include/asm-i386/mach-default/mach_apic.h:67: error: `nr_ioapics' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:91: error: syntax error before "apicid_to_cpu_present"
include/asm-i386/mach-default/mach_apic.h:92: warning: return type defaults to `int'
include/asm-i386/mach-default/mach_apic.h: In function `apicid_to_cpu_present':
include/asm-i386/mach-default/mach_apic.h:93: warning: implicit declaration of function `physid_mask_of_physid'
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:97: warning: `struct mpc_config_translation' declared inside parameter list
include/asm-i386/mach-default/mach_apic.h:97: warning: its scope is only this definition or declaration, which is probably not what you want
include/asm-i386/mach-default/mach_apic.h:97: warning: `struct mpc_config_processor' declared inside parameter list
include/asm-i386/mach-default/mach_apic.h: In function `mpc_apic_id':
include/asm-i386/mach-default/mach_apic.h:100: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h:101: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h:101: error: `CPU_FAMILY_MASK' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:102: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h:102: error: `CPU_MODEL_MASK' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:103: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h:104: error: dereferencing pointer to incomplete type
include/asm-i386/mach-default/mach_apic.h: In function `check_phys_apicid_present':
include/asm-i386/mach-default/mach_apic.h:113: error: `phys_cpu_present_map' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: In function `apic_id_registered':
include/asm-i386/mach-default/mach_apic.h:118: error: `APIC_ID' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:118: error: `phys_cpu_present_map' undeclared (first use in this function)
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:121: error: syntax error before "cpumask"
include/asm-i386/mach-default/mach_apic.h:122: warning: function declaration isn't a prototype
include/asm-i386/mach-default/mach_apic.h: In function `cpu_mask_to_apicid':
include/asm-i386/mach-default/mach_apic.h:123: warning: implicit declaration of function `cpus_coerce_const'
include/asm-i386/mach-default/mach_apic.h:123: error: `cpumask' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/cpu/intel.o] Error 1
make: *** [arch/i386/kernel/cpu/intel.o] Error 2


-- 
ilmari

