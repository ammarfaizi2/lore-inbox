Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUGIJ6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUGIJ6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGIJ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:58:38 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:8927 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S264774AbUGIJyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:54:24 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Date: Fri, 9 Jul 2004 02:54:17 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004C_01C46560.08F61FB0"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlmrMqcEoy4UF2Ss6i2LFMCBCW1w==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S264774AbUGIJyY/20040709095424Z+26@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_004C_01C46560.08F61FB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[SECOND SUBBMITAL - Thanks for all the comments]
Andrew,

Please find below one out of collection of patched that move NR_CPU =
array=20
variables to the per-cpu area.  Please consider applying, any comment =
will
highly appreciated.

Patches (altogether) tested using make allmodconfig, and defconfig, and
booted my system very nicely.

1/4. PER_CPU-cpu_gdt_table
2/4. PER_CPU-init_tss
3/4. PER_CPU-cpu_tlbstate
4/4. PER_CPU-irq_stat

PER_CPU-irq_stat:
 arch/i386/kernel/apic.c     |    2 +-
 arch/i386/kernel/io_apic.c  |    2 +-
 arch/i386/kernel/irq.c      |    3 ++-
 arch/i386/kernel/nmi.c      |    4 ++--
 arch/i386/kernel/process.c  |    2 +-
 include/linux/irq_cpustat.h |    4 ++--
 kernel/softirq.c            |    4 ++--
 7 files changed, 11 insertions(+), 10 deletions(-)

Signed-off-by: Martin Hicks <mort@wildopensource.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/09 01:33:31-07:00 shai@compile.(none)=20
#   softirq.c, irq_cpustat.h, process.c, nmi.c, irq.c, io_apic.c, =
apic.c:
#     PER_CPU-irq_stat
#   Convert irq_stat into a per_cpu variable.
#    =20
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>
#=20
# kernel/softirq.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2
#   PER_CPU-irq_stat
#=20
# include/linux/irq_cpustat.h
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2
#   PER_CPU-irq_stat
#=20
# arch/i386/kernel/process.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1
#   PER_CPU-irq_stat
#=20
# arch/i386/kernel/nmi.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2
#   PER_CPU-irq_stat
#=20
# arch/i386/kernel/irq.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -1
#   PER_CPU-irq_stat
#=20
# arch/i386/kernel/io_apic.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1
#   PER_CPU-irq_stat
#=20
# arch/i386/kernel/apic.c
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1
#   PER_CPU-irq_stat
#=20
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2004-07-09 01:34:13 -07:00
+++ b/arch/i386/kernel/apic.c	2004-07-09 01:34:13 -07:00
@@ -1093,7 +1093,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	irq_stat[cpu].apic_timer_irqs++;
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
=20
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	2004-07-09 01:34:13 -07:00
+++ b/arch/i386/kernel/io_apic.c	2004-07-09 01:34:13 -07:00
@@ -273,7 +273,7 @@
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
=20
 #define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat, (cpu)).idle_timestamp > =
1))
=20
 #define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)
=20
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-07-09 01:34:13 -07:00
+++ b/arch/i386/kernel/irq.c	2004-07-09 01:34:13 -07:00
@@ -187,7 +187,8 @@
 		seq_printf(p, "LOC: ");
 		for (j =3D 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
-				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+				seq_printf(p, "%10u ",
+					   per_cpu(irq_stat, j).apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -Nru a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
--- a/arch/i386/kernel/nmi.c	2004-07-09 01:34:13 -07:00
+++ b/arch/i386/kernel/nmi.c	2004-07-09 01:34:13 -07:00
@@ -106,7 +106,7 @@
 	printk(KERN_INFO "testing NMI watchdog ... ");
=20
 	for (cpu =3D 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] =3D irq_stat[cpu].__nmi_count;
+		prev_nmi_count[cpu] =3D per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
=20
@@ -469,7 +469,7 @@
 	 */
 	int sum, cpu =3D smp_processor_id();
=20
-	sum =3D irq_stat[cpu].apic_timer_irqs;
+	sum =3D per_cpu(irq_stat, cpu).apic_timer_irqs;
=20
 	if (last_irq_sums[cpu] =3D=3D sum) {
 		/*
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	2004-07-09 01:34:13 -07:00
+++ b/arch/i386/kernel/process.c	2004-07-09 01:34:13 -07:00
@@ -147,7 +147,7 @@
 			if (!idle)
 				idle =3D default_idle;
=20
-			irq_stat[smp_processor_id()].idle_timestamp =3D jiffies;
+			__get_cpu_var(irq_stat).idle_timestamp =3D jiffies;
 			idle();
 		}
 		schedule();
diff -Nru a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
--- a/include/linux/irq_cpustat.h	2004-07-09 01:34:13 -07:00
+++ b/include/linux/irq_cpustat.h	2004-07-09 01:34:13 -07:00
@@ -18,8 +18,8 @@
  */
=20
 #ifndef __ARCH_IRQ_STAT
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);	/* defined in =
kernel/softirq.h */
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat, cpu).member)
 #endif
=20
   /* arch independent irq_stat fields */
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00
+++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00
@@ -36,8 +36,8 @@
  */
=20
 #ifndef __ARCH_IRQ_STAT
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
-EXPORT_SYMBOL(irq_stat);
+DEFINE_PER_CPU(irq_cpustat_t, irq_stat) =
____cacheline_maxaligned_in_smp;
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
=20
 static struct softirq_action softirq_vec[32] =
__cacheline_aligned_in_smp;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

=A0
-----------------
Shai Fultheim
Scalex86.org



------=_NextPart_000_004C_01C46560.08F61FB0
Content-Type: application/octet-stream;
	name="rev-1.1822.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rev-1.1822.patch"

# This is a BitKeeper generated diff -Nru style patch.=0A=
#=0A=
# ChangeSet=0A=
#   2004/07/09 01:33:31-07:00 shai@compile.(none) =0A=
#   softirq.c, irq_cpustat.h, process.c, nmi.c, irq.c, io_apic.c, apic.c:=0A=
#     PER_CPU-irq_stat=0A=
#   Convert irq_stat into a per_cpu variable.=0A=
#     =0A=
#   Signed-off-by: Martin Hicks <mort@wildopensource.com>=0A=
#   Signed-off-by: Shai Fultheim <shai@scalex86.org>=0A=
# =0A=
# kernel/softirq.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# include/linux/irq_cpustat.h=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# arch/i386/kernel/process.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# arch/i386/kernel/nmi.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -2=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# arch/i386/kernel/irq.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +2 -1=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# arch/i386/kernel/io_apic.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
# arch/i386/kernel/apic.c=0A=
#   2004/07/09 01:29:29-07:00 shai@compile.(none) +1 -1=0A=
#   PER_CPU-irq_stat=0A=
# =0A=
diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c=0A=
--- a/arch/i386/kernel/apic.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/arch/i386/kernel/apic.c	2004-07-09 01:34:13 -07:00=0A=
@@ -1093,7 +1093,7 @@=0A=
 	/*=0A=
 	 * the NMI deadlock-detector uses this.=0A=
 	 */=0A=
-	irq_stat[cpu].apic_timer_irqs++;=0A=
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;=0A=
 =0A=
 	/*=0A=
 	 * NOTE! We'd better ACK the irq immediately,=0A=
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c=0A=
--- a/arch/i386/kernel/io_apic.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/arch/i386/kernel/io_apic.c	2004-07-09 01:34:13 -07:00=0A=
@@ -273,7 +273,7 @@=0A=
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])=0A=
 =0A=
 #define IDLE_ENOUGH(cpu,now) \=0A=
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))=0A=
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat, (cpu)).idle_timestamp > =
1))=0A=
 =0A=
 #define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)=0A=
 =0A=
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c=0A=
--- a/arch/i386/kernel/irq.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/arch/i386/kernel/irq.c	2004-07-09 01:34:13 -07:00=0A=
@@ -187,7 +187,8 @@=0A=
 		seq_printf(p, "LOC: ");=0A=
 		for (j =3D 0; j < NR_CPUS; j++)=0A=
 			if (cpu_online(j))=0A=
-				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);=0A=
+				seq_printf(p, "%10u ",=0A=
+					   per_cpu(irq_stat, j).apic_timer_irqs);=0A=
 		seq_putc(p, '\n');=0A=
 #endif=0A=
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));=0A=
diff -Nru a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c=0A=
--- a/arch/i386/kernel/nmi.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/arch/i386/kernel/nmi.c	2004-07-09 01:34:13 -07:00=0A=
@@ -106,7 +106,7 @@=0A=
 	printk(KERN_INFO "testing NMI watchdog ... ");=0A=
 =0A=
 	for (cpu =3D 0; cpu < NR_CPUS; cpu++)=0A=
-		prev_nmi_count[cpu] =3D irq_stat[cpu].__nmi_count;=0A=
+		prev_nmi_count[cpu] =3D per_cpu(irq_stat, cpu).__nmi_count;=0A=
 	local_irq_enable();=0A=
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks=0A=
 =0A=
@@ -469,7 +469,7 @@=0A=
 	 */=0A=
 	int sum, cpu =3D smp_processor_id();=0A=
 =0A=
-	sum =3D irq_stat[cpu].apic_timer_irqs;=0A=
+	sum =3D per_cpu(irq_stat, cpu).apic_timer_irqs;=0A=
 =0A=
 	if (last_irq_sums[cpu] =3D=3D sum) {=0A=
 		/*=0A=
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c=0A=
--- a/arch/i386/kernel/process.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/arch/i386/kernel/process.c	2004-07-09 01:34:13 -07:00=0A=
@@ -147,7 +147,7 @@=0A=
 			if (!idle)=0A=
 				idle =3D default_idle;=0A=
 =0A=
-			irq_stat[smp_processor_id()].idle_timestamp =3D jiffies;=0A=
+			__get_cpu_var(irq_stat).idle_timestamp =3D jiffies;=0A=
 			idle();=0A=
 		}=0A=
 		schedule();=0A=
diff -Nru a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h=0A=
--- a/include/linux/irq_cpustat.h	2004-07-09 01:34:13 -07:00=0A=
+++ b/include/linux/irq_cpustat.h	2004-07-09 01:34:13 -07:00=0A=
@@ -18,8 +18,8 @@=0A=
  */=0A=
 =0A=
 #ifndef __ARCH_IRQ_STAT=0A=
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */=0A=
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)=0A=
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);	/* defined in =
kernel/softirq.h */=0A=
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat, cpu).member)=0A=
 #endif=0A=
 =0A=
   /* arch independent irq_stat fields */=0A=
diff -Nru a/kernel/softirq.c b/kernel/softirq.c=0A=
--- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00=0A=
+++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00=0A=
@@ -36,8 +36,8 @@=0A=
  */=0A=
 =0A=
 #ifndef __ARCH_IRQ_STAT=0A=
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;=0A=
-EXPORT_SYMBOL(irq_stat);=0A=
+DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;=0A=
+EXPORT_PER_CPU_SYMBOL(irq_stat);=0A=
 #endif=0A=
 =0A=
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;=0A=

------=_NextPart_000_004C_01C46560.08F61FB0--

