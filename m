Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276489AbRJGRk6>; Sun, 7 Oct 2001 13:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276486AbRJGRkj>; Sun, 7 Oct 2001 13:40:39 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:5838 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S276483AbRJGRkd>;
	Sun, 7 Oct 2001 13:40:33 -0400
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain> <d3n136tc48.fsf@lxplus014.cern.ch> <15294.47999.501719.858693@cargo.ozlabs.ibm.com> <20011006.013819.17864926.davem@redhat.com> <15294.63138.941581.771248@cargo.ozlabs.ibm.com> <d3adz4u1gx.fsf@lxplus014.cern.ch> <15295.47686.932418.81948@cargo.ozlabs.ibm.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 07 Oct 2001 19:40:56 +0200
In-Reply-To: Paul Mackerras's message of "Sun, 7 Oct 2001 12:13:26 +1000 (EST)"
Message-ID: <d37ku7s5zr.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> Jes Sorensen writes:
>> I haven't looked at the ohci driver at all, however doesn't it
>> return anything but the dma address? No index, no offset, no
>> nothing? If thats the case, someone really needs to go visit the
>> designers with a large bat ;-(

Paul> The OHCI hardware works with linked lists of transfer
Paul> descriptors, using bus addresses for the pointers of course.
Paul> When a transfer descriptor is completed, it gets linked onto a
Paul> done-list by the hardware (on to the front of the list, so you
Paul> get the completed descriptors in reverse order).

Paul> There is no way to predict the completion order in general
Paul> because you can have transfers in progress to several different
Paul> devices, and to several endpoints on each device, at the same
Paul> time, which can each supply or accept data at different rates.

Ok, so this is actually quite similar to how the AceNIC does it,
however the great thing about the AceNIC descriptors is that it has an
opague field in the descriptor which you can use as an index into a
table or similar to dig out your dma descriptor addresses.

Jes
