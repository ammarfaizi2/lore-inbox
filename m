Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269407AbRGaTEC>; Tue, 31 Jul 2001 15:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269420AbRGaTDz>; Tue, 31 Jul 2001 15:03:55 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:21965 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269407AbRGaTDk>; Tue, 31 Jul 2001 15:03:40 -0400
Importance: Normal
Subject: [PATCH] register_inet6addr_notifier
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF119FF657.6688232C-ONC1256A9A.0063BDC0@de.ibm.com>
From: "Utz Bacher" <utz.bacher@de.ibm.com>
Date: Tue, 31 Jul 2001 21:03:41 +0200
X-MIMETrack: Serialize by Router on D12ML009/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 31/07/2001 21:03:41
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=C1256A9A0063BDC08f9e8a93df938690918cC1256A9A0063BDC0"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

--0__=C1256A9A0063BDC08f9e8a93df938690918cC1256A9A0063BDC0
Content-type: text/plain; charset=us-ascii

Hi Dave,

attached is a patch which introduces
* register_inet6addr_notifier
* unregister_inet6addr_notifier

and exports

* EXPORT_SYMBOL(ndisc_mc_map);
* EXPORT_SYMBOL(register_inet6addr_notifier);
* EXPORT_SYMBOL(unregister_inet6addr_notifier);

Purpose of this patch is to give drivers the possibility of learning, what
IP addresses are set in the stack. This is done for IPv4 in
net/ipv4/dev_inet.c, but is missing for IPv6. The feature is exploited by
cards which provide IP offload capabilities and therfore require knowledge
of IP addresses. ndisc_mc_map is also required for the IP-MAC handling of
those cards.

Could you please apply this, if there are no objections or otherwise tell
me, what needs to be done to get that knowledge otherwise?
(See attached file: register_inet6addr_notifier.diff.gz)

(sorry for the attachment, but my mail client would scramble the patch in
plain text :-(

Thanks,
Utz

Linux for S/390 and zSeries
:wq
--0__=C1256A9A0063BDC08f9e8a93df938690918cC1256A9A0063BDC0
Content-type: application/octet-stream; 
	name="register_inet6addr_notifier.diff.gz"
Content-Disposition: attachment; filename="register_inet6addr_notifier.diff.gz"
Content-transfer-encoding: base64

H4sICCr0ZjsAA2lwdjYtYWRkcmNvbmYuZGlmZgCdVf1vo0YQ/Rn+ipEqnRzAMeCPGKc9pT372rRJ
HKW+u1ZVtSKw2KviBcHii3V3/3tn+PBH7OSikBgLz8zbN7NvH6GIImgX2Q20H8DIu55tQCxk8dB2
T3unZx0hg7gIeUdy1fHDMAsSGZ0udlPaVPREnt5ut18Ap33iIVz7a3AG4HijrjNyz8C1bUc3TfOl
a2mzRQG/FxIAa7sjezjq1iAXF9AeDq0BmHh3HLi40IE/KJ5JWCUi1DStQWFpxiPxwLJg1cpVVgQK
cBEW8pUIOBj4bemglRfgVQzBSFJlgZAKYi5PznXQzY4B46pAJkpEgmdgdHSzXpFSMz4XOT4xgegD
Wpw1qZtl62d2HyfBf2DIewTfxSjkq1HwD3LlKxEgEk6XQ51eAlG3YOjAELd8YHOunpjGiQ5f9PA7
EqJtEulqsN2r4HBPjyQdiOdIzmbTXQfswci2R/3+M8o5hvA+E4gQg9MFpz/qoXK8rWx6fZIN3s9K
1fxQSw9+LKE7+ToPVHy6eIshLnEQhykhj/01ZZiPI83mlOWHhWmWBCzKK/BNjDrIcS/pZyLoeUTQ
sW1rWDKs95V0DRtVZzlTYomyKGQu5hIPW5zIOYS+8kmyuzU0HSYiv5LSukVS4ysuUeR7IsEURAcD
vyvV1yBPCG8r0WDhC3leSbDCoxVRS8R0/+EnUhdotkXnDU9VlGSf/SwUcq5peKKo/a7nUv9dr1/3
r33OhOKskLQuu1+03giEa7+lRyKqZdwP63DrzWZCTVg3tQ31wI/jii6C7PO3biaz8eQj+3BrVQMw
S2RV0OGMfAT6hlilgLrdUkHdYS0hTHw847vZNRtPrn4ej+/QSqL0FUTG0083VlMKWz9D9dVb3wSJ
lOP1Szt0vEHPcu2a10bDJnmYboIB5fXIzCjQoZzXO5lufkGU+qrHtu2W+mIN8GHHUJnYt4bCa43w
BSS20Ic0GhY4NhwWgKFdSqGgA0HMfVmkECQhf5E34idfL/OnXHETPuqHm2jthOhjLqAN9nqj3vec
8LDWxffv2Yhs0N564MAhreD9sQc2bnrEolBHeXDkd5X5Mk9ZVWPux7av8tIPd951lc3SIfVjliaZ
Yggz5/+4/57v5akgrcPJimfnJXt3aBN9d+hYXs0/CnkE76Y37y9/ZZe3Hwc6TP66nd7N2J9/X/8y
vWqV57PcarVOOZ2aR/FgSRk5nhbSwH6w7Jwt8d9PD6PPSPUw+VllE63tOycC7EmQs7d2GmPX0/GH
q8kJfP16EP/jt9nsdvxMqCkmfZemD1EhAyUSmaO2l8tEgkpg1QNfhrAakCn8D/x+189NCgAA

--0__=C1256A9A0063BDC08f9e8a93df938690918cC1256A9A0063BDC0--

