Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270988AbRHOBYu>; Tue, 14 Aug 2001 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270991AbRHOBYl>; Tue, 14 Aug 2001 21:24:41 -0400
Received: from web10901.mail.yahoo.com ([216.136.131.37]:54798 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270988AbRHOBY3>; Tue, 14 Aug 2001 21:24:29 -0400
Message-ID: <20010815012438.54245.qmail@web10901.mail.yahoo.com>
Date: Tue, 14 Aug 2001 18:24:38 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Broken QoS and PPPoE with 2.4.8
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

	I am compiling 2.4.8 for a Pentium computer with modutils 2.4.0 loaded. I
enabled various networking goodies like netfilter, QoS, PPP, etc. However, when
drivers/net/pppoe.o and all QoS modules (classifiers, algorithms, etc.)
are compiled as modules, depmod complains that various symbols are missing.
However, the symbols are present in /boot/System.map and /proc/ksyms!
	According to the modutils man page for depmod, if you compile
with CONFIG_MODVERSIONS, then depmod uses /proc/ksyms. When I use /proc/ksyms,
I get the errors. If I use /boot/System.map, I don't get the errors! And
when I attempt to load the module, using either System.map or ksyms, it
gives me errors.
	Enclosed with this message are the relevant parts of System.map,
/proc/ksyms, and .config, as well as the error output from depmod.

Thanks,

Brad

<snip>

</boot/2.4.8/System.map> c019c950 T qdisc_restart
c019cdb8 T qdisc_create_dflt
c019ce78 T qdisc_reset
c019ce90 T qdisc_destroy
c019d110 T register_qdisc
c019d194 T unregister_qdisc
c019d1d0 T qdisc_lookup
c019d1f4 T qdisc_leaf
c019d248 T qdisc_lookup_ops
c019d2c0 T qdisc_get_rtab
c019d370 T qdisc_put_rtab
c019d3cc T qdisc_alloc_handle
c019d428 t dev_graft_qdisc
c019d4e8 T qdisc_graft
c019d56c t qdisc_create
c019d76c t qdisc_change
c019d874 t tc_get_qdisc
c019da70 t tc_modify_qdisc
c019dea0 T qdisc_copy_stats
c019df18 t tc_fill_qdisc
c019e0a8 t qdisc_notify
c019e188 t tc_dump_qdisc
c019e664 t qdisc_class_dump
c019ec88 T qdisc_new_estimator
c019ee20 T qdisc_kill_estimator
c020a060 ? __kstrtab_qdisc_destroy
c020a078 ? __kstrtab_qdisc_reset
c020a08e ? __kstrtab_qdisc_restart
c020a0a6 ? __kstrtab_qdisc_create_dflt
c020a0c2 ? __kstrtab_noop_qdisc
c020a0d7 ? __kstrtab_qdisc_tree_lock
c020a100 ? __kstrtab_pfifo_qdisc_ops
c020a140 ? __kstrtab_register_qdisc
c020a180 ? __kstrtab_unregister_qdisc
c020a1c0 ? __kstrtab_qdisc_get_rtab
c020a200 ? __kstrtab_qdisc_put_rtab
c020a240 ? __kstrtab_qdisc_copy_stats
c020a280 ? __kstrtab_qdisc_new_estimator
c020a2c0 ? __kstrtab_qdisc_kill_estimator
c020d5a8 ? __ksymtab_qdisc_destroy
c020d5b0 ? __ksymtab_qdisc_reset
c020d5b8 ? __ksymtab_qdisc_restart
c020d5c0 ? __ksymtab_qdisc_create_dflt
c020d5c8 ? __ksymtab_noop_qdisc
c020d5d0 ? __ksymtab_qdisc_tree_lock
c020d5d8 ? __ksymtab_pfifo_qdisc_ops
c020d5e0 ? __ksymtab_register_qdisc
c020d5e8 ? __ksymtab_unregister_qdisc
c020d5f0 ? __ksymtab_qdisc_get_rtab
c020d5f8 ? __ksymtab_qdisc_put_rtab
c020d600 ? __ksymtab_qdisc_copy_stats
c020d608 ? __ksymtab_qdisc_new_estimator
c020d610 ? __ksymtab_qdisc_kill_estimator
c021b8e0 D qdisc_tree_lock
c021b900 D noop_qdisc_ops
c021b940 D noop_qdisc
c021b9a0 D noqueue_qdisc_ops
c021b9e0 D noqueue_qdisc
c021ba80 d qdisc_mod_lock
c021ba84 d qdisc_base
c021baa0 D pfifo_qdisc_ops
c021bae0 D bfifo_qdisc_ops
c027c1c8 b qdisc_rtab_list
c019eed0 T tcf_proto_lookup_ops
c019ef50 T register_tcf_proto_ops
c019efa8 T unregister_tcf_proto_ops
c019f554 t tcf_fill_node
c019f774 t tcf_node_dump
c019fa50 T tcf_police_destroy
c019fae8 T tcf_police_locate
c019fd38 T tcf_police
c019fe60 T tcf_police_dump
c020a2f1 ? __kstrtab_tcf_police
c020a320 ? __kstrtab_tcf_police_locate
c020a360 ? __kstrtab_tcf_police_destroy
c020a3a0 ? __kstrtab_tcf_police_dump
c020a3e0 ? __kstrtab_register_tcf_proto_ops
c020a420 ? __kstrtab_unregister_tcf_proto_ops
c020d618 ? __ksymtab_tcf_police
c020d620 ? __ksymtab_tcf_police_locate
c020d628 ? __ksymtab_tcf_police_destroy
c020d630 ? __ksymtab_tcf_police_dump
c020d638 ? __ksymtab_register_tcf_proto_ops
c020d640 ? __ksymtab_unregister_tcf_proto_ops
c027c270 b tcf_proto_base
c027c2a0 b tcf_police_ht
c0196064 T sk_run_filter
c0209100 ? __kstrtab_sk_run_filter
c020d140 ? __ksymtab_sk_run_filter

</proc/ksyms> c019ce90 qdisc_destroy_R0032158c
c019ce78 qdisc_reset_R3e10fa67
c019c950 qdisc_restart_R66714388
c019cdb8 qdisc_create_dflt_R11862d5d
c021b940 noop_qdisc_R0ea4824b
c021b8e0 qdisc_tree_lock_Re0089c56
c021baa0 pfifo_qdisc_ops_R__ver_pfifo_qdisc_ops
c019d110 register_qdisc_R__ver_register_qdisc
c019d194 unregister_qdisc_R__ver_unregister_qdisc
c019d2c0 qdisc_get_rtab_R__ver_qdisc_get_rtab
c019d370 qdisc_put_rtab_R__ver_qdisc_put_rtab
c019dea0 qdisc_copy_stats_R__ver_qdisc_copy_stats
c019ec88 qdisc_new_estimator_R__ver_qdisc_new_estimator
c019ee20 qdisc_kill_estimator_R__ver_qdisc_kill_estimator
c019fd38 tcf_police_R__ver_tcf_police
c019fae8 tcf_police_locate_R__ver_tcf_police_locate
c019fa50 tcf_police_destroy_R__ver_tcf_police_destroy
c019fe60 tcf_police_dump_R__ver_tcf_police_dump
c019ef50 register_tcf_proto_ops_R__ver_register_tcf_proto_ops
c019efa8 unregister_tcf_proto_ops_R__ver_unregister_tcf_proto_ops
c0196064 sk_run_filter_R__ver_sk_run_filter

</boot/2.4.8/.config> CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_POLICE=y
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m

<output of depmod> depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/drivers/net/pppoe.o
depmod: 	sk_run_filter
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/cls_fw.o
depmod: 	tcf_police_dump
depmod: 	qdisc_copy_stats
depmod: 	tcf_police
depmod: 	tcf_police_destroy
depmod: 	unregister_tcf_proto_ops
depmod: 	register_tcf_proto_ops
depmod: 	tcf_police_locate
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/cls_route.o
depmod: 	tcf_police_dump
depmod: 	qdisc_copy_stats
depmod: 	tcf_police
depmod: 	tcf_police_destroy
depmod: 	unregister_tcf_proto_ops
depmod: 	register_tcf_proto_ops
depmod: 	tcf_police_locate
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/cls_tcindex.o
depmod: 	tcf_police_dump
depmod: 	tcf_police
depmod: 	tcf_police_destroy
depmod: 	unregister_tcf_proto_ops
depmod: 	register_tcf_proto_ops
depmod: 	tcf_police_locate
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/cls_u32.o
depmod: 	tcf_police_dump
depmod: 	qdisc_copy_stats
depmod: 	tcf_police
depmod: 	tcf_police_destroy
depmod: 	unregister_tcf_proto_ops
depmod: 	register_tcf_proto_ops
depmod: 	tcf_police_locate
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/sch_cbq.o
depmod: 	qdisc_get_rtab
depmod: 	unregister_qdisc
depmod: 	qdisc_put_rtab
depmod: 	qdisc_copy_stats
depmod: 	register_qdisc
depmod: 	pfifo_qdisc_ops
depmod: 	qdisc_kill_estimator
depmod: 	qdisc_new_estimator
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/sch_csz.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/sch_dsmark.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: 	pfifo_qdisc_ops
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/sch_gred.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/sch_ingress.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/sch_prio.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: 	pfifo_qdisc_ops
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/sch_red.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/sch_sfq.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc
depmod: *** Unresolved symbols in /lib/modules/2.4.8/kernel/net/sched/sch_tbf.o
depmod: 	qdisc_get_rtab
depmod: 	unregister_qdisc
depmod: 	qdisc_put_rtab
depmod: 	register_qdisc
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/net/sched/sch_teql.o
depmod: 	unregister_qdisc
depmod: 	register_qdisc

<snip>


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net

Reply to the address I used in the message to you,
please!

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
