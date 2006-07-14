Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWGNMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWGNMhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWGNMhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 08:37:05 -0400
Received: from mail75.messagelabs.com ([216.82.250.3]:5854 "HELO
	mail75.messagelabs.com") by vger.kernel.org with SMTP
	id S1161096AbWGNMhE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 08:37:04 -0400
X-VirusChecked: Checked
X-Env-Sender: bhannibal@ipolicynetworks.com
X-Msg-Ref: server-2.tower-75.messagelabs.com!1152880621!44133791!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [203.190.138.195]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: RE: SMP share data declaration
Date: Fri, 14 Jul 2006 17:01:59 +0530
Message-ID: <D269C7CBDF116A48982D4DC51F111BE30213AF1C@nsezhpmail01.india.ipolicynet.com>
In-Reply-To: <9a8748490607140148x70663e27k2f03367165ab4c0b@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP share data declaration
Thread-Index: AcanOR7VWOuLlSqhQhWLArqTtaqItA==
From: "Hannibal B" <bhannibal@ipolicynetworks.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, <wyb@topsec.com.cn>
Cc: <linux-kernel@vger.kernel.org>
X-imss-version: 2.040
X-imss-result: Passed
X-imss-scanInfo: M:P L:E SM:0
X-imss-tmaseResult: TT:0 TS:0.0000 TC:00 TRN:0 TV:3.52.1006(14566.000)
X-imss-scores: Clean:99.90000 C:2 M:4 S:5 R:5
X-imss-settings: Baseline:2 C:1 M:1 S:1 R:1 (0.1500 0.1500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spinlocks would be the one to protect the variable and synchronies
between CPU, But it's a busy waiting mechanism(just a word of caution).
Regards,
Hannibal

-----Original Message-----
From: Jesper Juhl [mailto:jesper.juhl@gmail.com] 
Sent: Friday, July 14, 2006 2:18 PM
To: wyb@topsec.com.cn
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP share data declaration

On 14/07/06, wyb@topsec.com.cn <wyb@topsec.com.cn> wrote:
> I know that an integer variable should be declared volatile to share
between
> CPUs.

NO. volatile won't protect you sufficiently.

Use spinlocks, mutexes, semaphores, barriers and the like to protect
variables from concurrent access. Using volatile for this is a BUG and
it won't work correctly.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


