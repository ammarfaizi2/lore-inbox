Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCAOZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCAOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWCAOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:25:56 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:9482 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932216AbWCAOZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:25:55 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Date: Wed, 1 Mar 2006 13:59:55 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200602281619_MC3-1-B984-ED75@compuserve.com>
In-Reply-To: <200602281619_MC3-1-B984-ED75@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011359.55569.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 21:17, Chuck Ebbert wrote:
> Disable timer routing over 8254 when an ATI chipset is detected
> (autodetect is only implemented for ACPI, but these are new systems
> and should be using ACPI anyway.)  Adds boot options for manually
> disabling and enabling this feature. Also adds a note to the timer
> error message caused by this change explaining that this error
> is expected on ATI chipsets.
[snip]
>
>  	pin1  = find_isa_irq_pin(0, mp_INT);
>  	apic1 = find_isa_irq_apic(0, mp_INT);
> @@ -2294,7 +2311,7 @@ static inline void check_timer(void)
>  		}
>  		clear_IO_APIC_pin(apic1, pin1);
>  		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to "
> -				"IO-APIC\n");
> +				"IO-APIC (expected on ATI chipsets)\n");
>  	}
>

This hunk looks bogus. My understanding is that this is a BIOS bug that some 
vendors have started to correct. We shouldn't acknowledge vendor BIOS bugs as 
"expected", imo..

I had this message for years with my nForce2/nForce3 boards and eventually it 
was repaired.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
