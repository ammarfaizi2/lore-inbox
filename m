Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWEVRbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWEVRbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWEVRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:31:45 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:20937 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751079AbWEVRbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:31:44 -0400
To: dzickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       oprofile-list@lists.sourceforge.net
Subject: Re: [patch 5/8] Add SMP support on i386 to reservation framework
References: <20060509205035.446349000@drseuss.boston.redhat.com>
	<20060509205957.466442000@drseuss.boston.redhat.com>
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 May 2006 19:31:41 +0200
In-Reply-To: <20060509205957.466442000@drseuss.boston.redhat.com> (dzickus@redhat.com's message of "Tue, 09 May 2006 16:50:40 -0400")
Message-ID: <87mzdage4i.fsf@pike.pond.sub.org>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -457,143 +434,312 @@ late_initcall(init_lapic_nmi_sysfs);
[...]
 static int setup_p6_watchdog(void)
[...]
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= P6_EVNTSEL0_ENABLE;
-	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+	evntsel |= K7_EVNTSEL_ENABLE;

Me thinks you want P6_EVNTSEL0_ENABLE here, although the value is the
same.
