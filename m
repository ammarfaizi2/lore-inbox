Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJFRXo>; Sat, 6 Oct 2001 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275320AbRJFRXe>; Sat, 6 Oct 2001 13:23:34 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:5547 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S275224AbRJFRXX>;
	Sat, 6 Oct 2001 13:23:23 -0400
To: paulus@samba.org
Cc: "David S. Miller" <davem@redhat.com>,
        James.Bottomley@HansenPartnership.com, linuxopinion@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain> <d3n136tc48.fsf@lxplus014.cern.ch> <15294.47999.501719.858693@cargo.ozlabs.ibm.com> <20011006.013819.17864926.davem@redhat.com> <15294.63138.941581.771248@cargo.ozlabs.ibm.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 06 Oct 2001 19:23:26 +0200
In-Reply-To: Paul Mackerras's message of "Sat, 6 Oct 2001 22:18:42 +1000 (EST)"
Message-ID: <d3adz4u1gx.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> David S. Miller writes:
>> I can not even count on one hand how many people I've helped
>> converting, who wanted a bus_to_virt() and when I showed them how
>> to do it with information the device provided already they said "oh
>> wow, I never would have thought of that".  That process won't
>> happen as often with the suggested feature.

Paul> Well, let's see if we can come up with a way to achieve this
Paul> goal as well as the other.

Paul> I look at all the hash-table stuff in the usb-ohci driver and I
Paul> think to myself about all the complexity that is there (and I
Paul> haven't managed to convince myself yet that it is actually
Paul> SMP-safe) and all the time wasted doing that stuff, when on
Paul> probably 95% of the machines that use the usb-ohci driver, the
Paul> hashing stuff is totally unnecessary.  I am talking about
Paul> powermacs, which don't have an iommu, and where the reverse
Paul> mapping is as simple as adding a constant.

I haven't looked at the ohci driver at all, however doesn't it return
anything but the dma address? No index, no offset, no nothing? If
thats the case, someone really needs to go visit the designers with a
large bat ;-(

Jes
