Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315105AbSDWIcB>; Tue, 23 Apr 2002 04:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315106AbSDWIcA>; Tue, 23 Apr 2002 04:32:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48905 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315105AbSDWIcA>; Tue, 23 Apr 2002 04:32:00 -0400
Date: Tue, 23 Apr 2002 09:31:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: paulus@samba.org, rml@tech9.net, george@mvista.com,
        linux-kernel@vger.kernel.org
Subject: Re: in_interrupt race
Message-ID: <20020423093151.A17302@flint.arm.linux.org.uk>
In-Reply-To: <15553.17071.88897.914713@argo.ozlabs.ibm.com> <1019502174.939.50.camel@phantasy> <3CC48321.5855B08A@mvista.com> <1019512494.1465.5.camel@phantasy> <15556.38775.439624.762586@argo.ozlabs.ibm.com> <20020423132524.2056739f.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 01:25:24PM +1000, Rusty Russell wrote:
> Yes: the old CPU happens to be processing an interrupt now.
> The neat solution is to follow Linus' original instinct and make
> PREEMPT an option only for UP: I only like preempt because it brings
> UP into line with SMP, effectively enlarging the SMP userbase to reasonable
> size.

> -bool 'Preemptible kernel' CONFIG_PREEMPT
> +dep_bool 'Preemptible kernel' CONFIG_PREEMPT $CONFIG_SMP
> -bool 'Preemptible Kernel' CONFIG_PREEMPT
> +dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_SMP

Do you really mean that CONFIG_PREEMPT is only available if CONFIG_SMP is
'y' or undefined?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

