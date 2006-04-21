Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWDUIwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWDUIwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDUIwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:52:53 -0400
Received: from fmr17.intel.com ([134.134.136.16]:48291 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750807AbWDUIwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:52:53 -0400
Message-ID: <44489D58.3090209@linux.intel.com>
Date: Fri, 21 Apr 2006 12:52:40 +0400
From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com>	 <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com>	 <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com>	 <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com>	 <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com> <1145563624.14595.5.camel@bip.parateam.prv>
In-Reply-To: <1145563624.14595.5.camel@bip.parateam.prv>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> Le jeudi 20 avril 2006 à 15:30 -0400, Dmitry Torokhov a écrit :
>> On 4/20/06, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com> wrote:
>>> Xavier Bestel wrote:
>>>> There are keyboards with power/sleep buttons. It makes sense they have
>>>> the same behavior than ACPI buttons.
>>> Agree, make them behave like ACPI buttons -- remove them from input stream, as they do not belong there...
>> What if there is no ACPI? What if I want to remap the button to do
>> something else? Input layer is the proper place for them.
> 
> Err .. that's what I meant, sorry I was not clear. Matthew's solution
> looks right.
If there is no ACPI, you don't have ACPI buttons to remap. Remapping power/lid/sleep button is not wise at least, just because you boot once with acpi=off and get unclean shutdown instead of your intended remapped keystroke.
