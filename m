Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSE0V7V>; Mon, 27 May 2002 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSE0V7U>; Mon, 27 May 2002 17:59:20 -0400
Received: from jalon.able.es ([212.97.163.2]:16287 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316768AbSE0V7T>;
	Mon, 27 May 2002 17:59:19 -0400
Date: Mon, 27 May 2002 23:59:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020527215911.GC1848@werewolf.able.es>
In-Reply-To: <20020527145420.GA6738@werewolf.able.es> <1022520676.11859.294.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.27 Alan Cox wrote:
>On Mon, 2002-05-27 at 15:54, J.A. Magallon wrote:
>
>> +static void __init check_intel_compat(struct cpuinfo_x86 *c)
>> +{
>> +#if defined(CONFIG_MPENTIUMII) || defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
>> +	if (c->x86 <= 5)
>> +		panic("Kernel is unsafe/incompatible with this CPU model. Check your build settings !\n");
>> +#endif
>
>The PPro is also model 6 but a different family (1 if I remember
>rightly)
>

Opps... typo.
Yes:

    { X86_VENDOR_INTEL, 6,
      { "Pentium Pro A-step", "Pentium Pro", NULL, "Pentium II (Klamath)",
        NULL, "Pentium II (Deschutes)", "Mobile Pentium II",
        "Pentium III (Katmai)", "Pentium III (Coppermine)", NULL,
        "Pentium III (Cascades)", NULL, NULL, NULL, NULL }},

Corrected patch on the way...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
