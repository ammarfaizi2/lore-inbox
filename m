Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131467AbRBMNZT>; Tue, 13 Feb 2001 08:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbRBMNZJ>; Tue, 13 Feb 2001 08:25:09 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:16813 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131467AbRBMNZD>; Tue, 13 Feb 2001 08:25:03 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: cowboy@vnet.ibm.com (Richard A Nelson), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre10
In-Reply-To: <E14Sf7T-0001ia-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 13 Feb 2001 14:29:47 +0100
In-Reply-To: <E14Sf7T-0001ia-00@the-village.bc.nu>
Message-ID: <m37l2u7ltg.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 13 Feb 2001, Alan Cox wrote:
>> No, I do not think that it's minor. We had to bring down running
>> application servers to be able to start another one, because the
>> new one couldn't create or attach the systemwide os-monitoring
>> segment and thus refused to start. That's very bad behaviour.
> 
> Well I'll take corrected fixes, but Im not going to hold up a release for it

Yes, I understand that. But I never got any note that my fix is broken
and I still do not understand what's the concern. 

We are holding the BKL while doing this. And if shm_close does not get
called with it we should probably acquire it.

Greetings
		Christoph


