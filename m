Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWIZGvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWIZGvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 02:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWIZGvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 02:51:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:988 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751661AbWIZGvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 02:51:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XxF2eFvZzStegeKNTbKiItOmlgDJh3tYrEZVJpsAiAiPJXMekdoiu/6ozB37ZwuGFG8bgtYki8ViptswwMzaoypVgMVEVZXkxC761GLb+k5BZtkwfhsCJNjOO3p/5WZW6wI6G5JP0+u88QjO3z+ibTQ3vEUeb2Rmuu/f3y/syUc=
Message-ID: <4518CE01.1060801@gmail.com>
Date: Tue, 26 Sep 2006 08:51:45 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "bibo,mao" <bibo.mao@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: Re: [PATCH 1/3] kprobe whitespace cleanup
References: <4518B446.8000503@intel.com>
In-Reply-To: <4518B446.8000503@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bibo,mao wrote:
> Hi,
> 
> Whitespace is used to indent, this patch cleans up these sentences by 
> kernel coding style.
> 
> Signed-off-by: bibo, mao <bibo.mao@intel.com>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> thanks
> bibo,mao
>  
> arch/i386/kernel/kprobes.c    |   34 ++++++++--------
> arch/ia64/kernel/kprobes.c    |   88 
> +++++++++++++++++++++---------------------
> arch/powerpc/kernel/kprobes.c |   26 ++++++------
> arch/x86_64/kernel/kprobes.c  |   41 +++++++++----------
> include/asm-ia64/kprobes.h    |   10 ++--
> kernel/kprobes.c              |   16 +++----
> 6 files changed, 107 insertions(+), 108 deletions(-)
> diff -Nruap 2.6.18-mm1.org/arch/i386/kernel/kprobes.c 
> 2.6.18-mm1/arch/i386/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/i386/kernel/kprobes.c    2006-09-26 
> 10:16:39.000000000 +0800
> +++ 2.6.18-mm1/arch/i386/kernel/kprobes.c    2006-09-26 
> 10:21:41.000000000 +0800
> @@ -230,20 +230,20 @@ void __kprobes arch_prepare_kretprobe(st
>                       struct pt_regs *regs)
> {
>     unsigned long *sara = (unsigned long *)&regs->esp;
> -        struct kretprobe_instance *ri;
> 
> -        if ((ri = get_free_rp_inst(rp)) != NULL) {
> -                ri->rp = rp;
> -                ri->task = current;
> +    struct kretprobe_instance *ri;
> +
> +    if ((ri = get_free_rp_inst(rp)) != NULL) {
> +        ri->rp = rp;
> +        ri->task = current;
>         ri->ret_addr = (kprobe_opcode_t *) *sara;
> 
>         /* Replace the return addr with trampoline addr */
>         *sara = (unsigned long) &kretprobe_trampoline;
> -
> -                add_rp_inst(ri);
> -        } else {
> -                rp->nmissed++;
> -        }
> +        add_rp_inst(ri);
> +    } else {
> +        rp->nmissed++;
> +    }
> }
> 
> /*
> @@ -359,7 +359,7 @@ no_kprobe:
>  void __kprobes kretprobe_trampoline_holder(void)
>  {
>     asm volatile ( ".global kretprobe_trampoline\n"
> -             "kretprobe_trampoline: \n"
> +            "kretprobe_trampoline: \n"
>             "    pushf\n"
>             /* skip cs, eip, orig_eax, es, ds */
>             "    subl $20, %esp\n"
> @@ -395,14 +395,14 @@ no_kprobe:
>  */
> fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
> {
> -        struct kretprobe_instance *ri = NULL;
> -        struct hlist_head *head;
> -        struct hlist_node *node, *tmp;
> +    struct kretprobe_instance *ri = NULL;
> +    struct hlist_head *head;
> +    struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
>     spin_lock_irqsave(&kretprobe_lock, flags);
> -        head = kretprobe_inst_table_head(current);
> +    head = kretprobe_inst_table_head(current);
> 
>     /*
>      * It is possible to have multiple instances associated with a given
> @@ -413,14 +413,14 @@ fastcall void *__kprobes trampoline_hand
>      * We can handle this because:
>      *     - instances are always inserted at the head of the list
>      *     - when multiple return probes are registered for the same
> -         *       function, the first instance's ret_addr will point to the
> +     *       function, the first instance's ret_addr will point to the
>      *       real return address, and all the rest will point to
>      *       kretprobe_trampoline
>      */
>     hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
> -                if (ri->task != current)
> +        if (ri->task != current)
>             /* another task is sharing our hash bucket */
> -                        continue;
> +            continue;
> 
>         if (ri->rp && ri->rp->handler){
>             __get_cpu_var(current_kprobe) = &ri->rp->kp;
> diff -Nruap 2.6.18-mm1.org/arch/ia64/kernel/kprobes.c 
> 2.6.18-mm1/arch/ia64/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/ia64/kernel/kprobes.c    2006-09-25 
> 16:11:56.000000000 +0800
> +++ 2.6.18-mm1/arch/ia64/kernel/kprobes.c    2006-09-26 
> 10:36:59.000000000 +0800
> @@ -90,7 +90,7 @@ static void __kprobes update_kprobe_inst
>     p->ainsn.target_br_reg = 0;
> 
>     /* Check for Break instruction
> -      * Bits 37:40 Major opcode to be zero
> +     * Bits 37:40 Major opcode to be zero
>      * Bits 27:32 X6 to be zero
>      * Bits 32:35 X3 to be zero
>      */
> @@ -104,19 +104,19 @@ static void __kprobes update_kprobe_inst
>         switch (major_opcode) {
>           case INDIRECT_CALL_OPCODE:
>              p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
> -             p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
> -             break;
> +            p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
> +            break;
>           case IP_RELATIVE_PREDICT_OPCODE:
>           case IP_RELATIVE_BRANCH_OPCODE:
>             p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
> -             break;
> +            break;
>           case IP_RELATIVE_CALL_OPCODE:
> -             p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
> -             p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
> -             p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
> -             break;
> +            p->ainsn.inst_flag |= INST_FLAG_FIX_RELATIVE_IP_ADDR;
> +            p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
> +            p->ainsn.target_br_reg = ((kprobe_inst >> 6) & 0x7);
> +            break;
>         }
> -     } else if (bundle_encoding[template][slot] == X) {
> +    } else if (bundle_encoding[template][slot] == X) {
>         switch (major_opcode) {
>           case LONG_CALL_OPCODE:
>             p->ainsn.inst_flag |= INST_FLAG_FIX_BRANCH_REG;
> @@ -260,18 +260,18 @@ static void __kprobes get_kprobe_inst(bu
> 
>     switch (slot) {
>       case 0:
> -         *major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
> -         *kprobe_inst = bundle->quad0.slot0;
> -        break;
> +        *major_opcode = (bundle->quad0.slot0 >> SLOT0_OPCODE_SHIFT);
> +        *kprobe_inst = bundle->quad0.slot0;
> +          break;
>       case 1:
> -         *major_opcode = (bundle->quad1.slot1_p1 >> 
> SLOT1_p1_OPCODE_SHIFT);
> -          kprobe_inst_p0 = bundle->quad0.slot1_p0;
> -          kprobe_inst_p1 = bundle->quad1.slot1_p1;
> -          *kprobe_inst = kprobe_inst_p0 | (kprobe_inst_p1 << (64-46));
> +        *major_opcode = (bundle->quad1.slot1_p1 >> SLOT1_p1_OPCODE_SHIFT);
> +        kprobe_inst_p0 = bundle->quad0.slot1_p0;
> +        kprobe_inst_p1 = bundle->quad1.slot1_p1;
> +        *kprobe_inst = kprobe_inst_p0 | (kprobe_inst_p1 << (64-46));
>         break;
>       case 2:
> -         *major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
> -         *kprobe_inst = bundle->quad1.slot2;
> +        *major_opcode = (bundle->quad1.slot2 >> SLOT2_OPCODE_SHIFT);
> +        *kprobe_inst = bundle->quad1.slot2;
>         break;
>     }
> }
> @@ -292,11 +292,11 @@ static int __kprobes valid_kprobe_addr(i
>         return -EINVAL;
>     }
> 
> -     if (in_ivt_functions(addr)) {
> -         printk(KERN_WARNING "Kprobes can't be inserted inside "
> +    if (in_ivt_functions(addr)) {
> +        printk(KERN_WARNING "Kprobes can't be inserted inside "
>                 "IVT functions at 0x%lx\n", addr);
> -         return -EINVAL;
> -     }
> +        return -EINVAL;
> +    }
> 
>     if (slot == 1 && bundle_encoding[template][1] != L) {
>         printk(KERN_WARNING "Inserting kprobes on slot #1 "
> @@ -428,14 +428,14 @@ int __kprobes arch_prepare_kprobe(struct
>     memcpy(&p->opcode.bundle, kprobe_addr, sizeof(bundle_t));
>     memcpy(&p->ainsn.insn.bundle, kprobe_addr, sizeof(bundle_t));
> 
> -     template = bundle->quad0.template;
> +    template = bundle->quad0.template;
> 
>     if(valid_kprobe_addr(template, slot, addr))
>         return -EINVAL;
> 
>     /* Move to slot 2, if bundle is MLX type and kprobe slot is 1 */
> -     if (slot == 1 && bundle_encoding[template][1] == L)
> -          slot++;
> +    if (slot == 1 && bundle_encoding[template][1] == L)
> +        slot++;
> 
>     /* Get kprobe_inst and major_opcode from the bundle */
>     get_kprobe_inst(bundle, slot, &kprobe_inst, &major_opcode);
> @@ -486,21 +486,21 @@ void __kprobes arch_disarm_kprobe(struct
>  */
> static void __kprobes resume_execution(struct kprobe *p, struct pt_regs 
> *regs)
> {
> -      unsigned long bundle_addr = ((unsigned long) (&p->opcode.bundle)) 
> & ~0xFULL;
> -      unsigned long resume_addr = (unsigned long)p->addr & ~0xFULL;
> -     unsigned long template;
> -     int slot = ((unsigned long)p->addr & 0xf);
> +    unsigned long bundle_addr = ((unsigned long) (&p->opcode.bundle)) & 
> ~0xFULL;
> +    unsigned long resume_addr = (unsigned long)p->addr & ~0xFULL;
> +    unsigned long template;
> +    int slot = ((unsigned long)p->addr & 0xf);
> 
>     template = p->opcode.bundle.quad0.template;
> 
> -     if (slot == 1 && bundle_encoding[template][1] == L)
> -         slot = 2;
> +    if (slot == 1 && bundle_encoding[template][1] == L)
> +        slot = 2;
> 
>     if (p->ainsn.inst_flag) {
> 
>         if (p->ainsn.inst_flag & INST_FLAG_FIX_RELATIVE_IP_ADDR) {
>             /* Fix relative IP address */
> -             regs->cr_iip = (regs->cr_iip - bundle_addr) + resume_addr;
> +            regs->cr_iip = (regs->cr_iip - bundle_addr) + resume_addr;
>         }
> 
>         if (p->ainsn.inst_flag & INST_FLAG_FIX_BRANCH_REG) {
> @@ -537,18 +537,18 @@ static void __kprobes resume_execution(s
>     }
> 
>     if (slot == 2) {
> -         if (regs->cr_iip == bundle_addr + 0x10) {
> -             regs->cr_iip = resume_addr + 0x10;
> -         }
> -     } else {
> -         if (regs->cr_iip == bundle_addr) {
> -             regs->cr_iip = resume_addr;
> -         }
> +        if (regs->cr_iip == bundle_addr + 0x10) {
> +            regs->cr_iip = resume_addr + 0x10;
> +        }
> +    } else {
> +        if (regs->cr_iip == bundle_addr) {
> +            regs->cr_iip = resume_addr;
> +        }
>     }
> 
> turn_ss_off:
> -      /* Turn off Single Step bit */
> -      ia64_psr(regs)->ss = 0;
> +    /* Turn off Single Step bit */
> +    ia64_psr(regs)->ss = 0;
> }
> 
> static void __kprobes prepare_ss(struct kprobe *p, struct pt_regs *regs)
> @@ -584,7 +584,7 @@ static int __kprobes is_ia64_break_inst(
> 
>     /* Move to slot 2, if bundle is MLX type and kprobe slot is 1 */
>     if (slot == 1 && bundle_encoding[template][1] == L)
> -          slot++;
> +        slot++;
> 
>     /* Get Kprobe probe instruction at given slot*/
>     get_kprobe_inst(&bundle, slot, &kprobe_inst, &major_opcode);
> @@ -624,7 +624,7 @@ static int __kprobes pre_kprobes_handler
>         if (p) {
>             if ((kcb->kprobe_status == KPROBE_HIT_SS) &&
>                   (p->ainsn.inst_flag == INST_FLAG_BREAK_INST)) {
> -                  ia64_psr(regs)->ss = 0;
> +                ia64_psr(regs)->ss = 0;
>                 goto no_kprobe;
>             }
>             /* We have reentered the pre_kprobe_handler(), since
> @@ -884,7 +884,7 @@ int __kprobes setjmp_pre_handler(struct      * fix 
> the return address to our jprobe_inst_return() function
>      * in the jprobes.S file
>      */
> -     regs->b0 = ((struct fnptr *)(jprobe_inst_return))->ip;
> +    regs->b0 = ((struct fnptr *)(jprobe_inst_return))->ip;
> 
>     return 1;
> }
> diff -Nruap 2.6.18-mm1.org/arch/powerpc/kernel/kprobes.c 
> 2.6.18-mm1/arch/powerpc/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/powerpc/kernel/kprobes.c    2006-09-26 
> 10:16:28.000000000 +0800
> +++ 2.6.18-mm1/arch/powerpc/kernel/kprobes.c    2006-09-26 
> 10:41:46.000000000 +0800
> @@ -259,14 +259,14 @@ void kretprobe_trampoline_holder(void)
>  */
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
> -        struct kretprobe_instance *ri = NULL;
> -        struct hlist_head *head;
> -        struct hlist_node *node, *tmp;
> +    struct kretprobe_instance *ri = NULL;
> +    struct hlist_head *head;
> +    struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
>     spin_lock_irqsave(&kretprobe_lock, flags);
> -        head = kretprobe_inst_table_head(current);
> +    head = kretprobe_inst_table_head(current);
> 
>     /*
>      * It is possible to have multiple instances associated with a given
> @@ -277,14 +277,14 @@ int __kprobes trampoline_probe_handler(s
>      * We can handle this because:
>      *     - instances are always inserted at the head of the list
>      *     - when multiple return probes are registered for the same
> -         *       function, the first instance's ret_addr will point to the
> +     *       function, the first instance's ret_addr will point to the
>      *       real return address, and all the rest will point to
>      *       kretprobe_trampoline
>      */
>     hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
> -                if (ri->task != current)
> +        if (ri->task != current)
>             /* another task is sharing our hash bucket */
> -                        continue;
> +            continue;
> 
>         if (ri->rp && ri->rp->handler)
>             ri->rp->handler(ri, regs);
> @@ -308,12 +308,12 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> -        /*
> -         * By returning a non-zero value, we are telling
> -         * kprobe_handler() that we don't want the post_handler
> -         * to run (and have re-enabled preemption)
> -         */
> -        return 1;
> +    /*
> +     * By returning a non-zero value, we are telling
> +     * kprobe_handler() that we don't want the post_handler
> +     * to run (and have re-enabled preemption)
> +     */
> +    return 1;
> }
> 
> /*
> diff -Nruap 2.6.18-mm1.org/arch/x86_64/kernel/kprobes.c 
> 2.6.18-mm1/arch/x86_64/kernel/kprobes.c
> --- 2.6.18-mm1.org/arch/x86_64/kernel/kprobes.c    2006-09-26 
> 10:16:28.000000000 +0800
> +++ 2.6.18-mm1/arch/x86_64/kernel/kprobes.c    2006-09-26 
> 10:43:55.000000000 +0800
> @@ -270,20 +270,19 @@ void __kprobes arch_prepare_kretprobe(st
>                       struct pt_regs *regs)
> {
>     unsigned long *sara = (unsigned long *)regs->rsp;
> -        struct kretprobe_instance *ri;
> +    struct kretprobe_instance *ri;
> 
> -        if ((ri = get_free_rp_inst(rp)) != NULL) {
> -                ri->rp = rp;
> -                ri->task = current;
> +    if ((ri = get_free_rp_inst(rp)) != NULL) {
> +        ri->rp = rp;
> +        ri->task = current;
>         ri->ret_addr = (kprobe_opcode_t *) *sara;
> 
>         /* Replace the return addr with trampoline addr */
>         *sara = (unsigned long) &kretprobe_trampoline;
> -
> -                add_rp_inst(ri);
> -        } else {
> -                rp->nmissed++;
> -        }
> +        add_rp_inst(ri);
> +    } else {
> +        rp->nmissed++;
> +    }
> }
> 
> int __kprobes kprobe_handler(struct pt_regs *regs)
> @@ -405,14 +404,14 @@ no_kprobe:
>  */
> int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs 
> *regs)
> {
> -        struct kretprobe_instance *ri = NULL;
> -        struct hlist_head *head;
> -        struct hlist_node *node, *tmp;
> +    struct kretprobe_instance *ri = NULL;
> +    struct hlist_head *head;
> +    struct hlist_node *node, *tmp;
>     unsigned long flags, orig_ret_address = 0;
>     unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
>     spin_lock_irqsave(&kretprobe_lock, flags);
> -        head = kretprobe_inst_table_head(current);
> +    head = kretprobe_inst_table_head(current);
> 
>     /*
>      * It is possible to have multiple instances associated with a given
> @@ -423,14 +422,14 @@ int __kprobes trampoline_probe_handler(s
>      * We can handle this because:
>      *     - instances are always inserted at the head of the list
>      *     - when multiple return probes are registered for the same
> -         *       function, the first instance's ret_addr will point to the
> +     *       function, the first instance's ret_addr will point to the
>      *       real return address, and all the rest will point to
>      *       kretprobe_trampoline
>      */
>     hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
> -                if (ri->task != current)
> +        if (ri->task != current)
>             /* another task is sharing our hash bucket */
> -                        continue;
> +            continue;
> 
>         if (ri->rp && ri->rp->handler)
>             ri->rp->handler(ri, regs);
> @@ -454,12 +453,12 @@ int __kprobes trampoline_probe_handler(s
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
>     preempt_enable_no_resched();
> 
> -        /*
> -         * By returning a non-zero value, we are telling
> -         * kprobe_handler() that we don't want the post_handler
> +    /*
> +     * By returning a non-zero value, we are telling
> +     * kprobe_handler() that we don't want the post_handler
>      * to run (and have re-enabled preemption)
> -         */
> -        return 1;
> +     */
> +    return 1;
> }
> 
> /*
> diff -Nruap 2.6.18-mm1.org/include/asm-ia64/kprobes.h 
> 2.6.18-mm1/include/asm-ia64/kprobes.h
> --- 2.6.18-mm1.org/include/asm-ia64/kprobes.h    2006-09-25 
> 15:20:50.000000000 +0800
> +++ 2.6.18-mm1/include/asm-ia64/kprobes.h    2006-09-26 
> 10:21:41.000000000 +0800
> @@ -109,11 +109,11 @@ struct fnptr {
> struct arch_specific_insn {
>     /* copy of the instruction to be emulated */
>     kprobe_opcode_t insn;
> - #define INST_FLAG_FIX_RELATIVE_IP_ADDR        1
> - #define INST_FLAG_FIX_BRANCH_REG        2
> - #define INST_FLAG_BREAK_INST            4
> -     unsigned long inst_flag;
> -     unsigned short target_br_reg;
> +#define INST_FLAG_FIX_RELATIVE_IP_ADDR        1
> +#define INST_FLAG_FIX_BRANCH_REG        2
> +#define INST_FLAG_BREAK_INST            4
> +    unsigned long inst_flag;
> +    unsigned short target_br_reg;
> };
> 
> extern int kprobe_exceptions_notify(struct notifier_block *self,
> diff -Nruap 2.6.18-mm1.org/kernel/kprobes.c 2.6.18-mm1/kernel/kprobes.c
> --- 2.6.18-mm1.org/kernel/kprobes.c    2006-09-26 10:16:28.000000000 +0800
> +++ 2.6.18-mm1/kernel/kprobes.c    2006-09-26 10:21:41.000000000 +0800
> @@ -347,17 +347,17 @@ struct hlist_head __kprobes *kretprobe_i
>  */
> void __kprobes kprobe_flush_task(struct task_struct *tk)
> {
> -        struct kretprobe_instance *ri;
> -        struct hlist_head *head;
> +    struct kretprobe_instance *ri;
> +    struct hlist_head *head;

Spaces for indenting? Tabs are indenting chars.

>     struct hlist_node *node, *tmp;
>     unsigned long flags = 0;
> 
>     spin_lock_irqsave(&kretprobe_lock, flags);
> -        head = kretprobe_inst_table_head(tk);
> -        hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
> -                if (ri->task == tk)
> -                        recycle_rp_inst(ri);
> -        }
> +    head = kretprobe_inst_table_head(tk);
> +    hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
> +        if (ri->task == tk)
> +            recycle_rp_inst(ri);
> +    }
>     spin_unlock_irqrestore(&kretprobe_lock, flags);
> }
> 
> @@ -514,7 +514,7 @@ static int __kprobes __register_kprobe(s
>                 (ARCH_INACTIVE_KPROBE_COUNT + 1))
>         register_page_fault_notifier(&kprobe_page_fault_nb);
> 
> -      arch_arm_kprobe(p);
> +    arch_arm_kprobe(p);
> 
> out:
>     mutex_unlock(&kprobe_mutex);

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
