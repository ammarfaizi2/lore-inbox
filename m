Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbRCQEhc>; Fri, 16 Mar 2001 23:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbRCQEhX>; Fri, 16 Mar 2001 23:37:23 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:57618 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131546AbRCQEhK>;
	Fri, 16 Mar 2001 23:37:10 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103170435.f2H4ZnB65925@saturn.cs.uml.edu>
Subject: Re: [PATCH] Improved version reporting
To: Andries.Brouwer@cwi.nl
Date: Fri, 16 Mar 2001 23:35:49 -0500 (EST)
Cc: acahalan@cs.uml.edu, viro@math.psu.edu, alan@lxorguk.ukuu.org.uk,
        linus@transmeta.com, linux-kernel@vger.kernel.org, rhw@memalpha.cx,
        seberino@spawar.navy.mil
In-Reply-To: <UTC200103150952.KAA451302.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 15, 2001 10:52:25 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer writes:
>> From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
>>> On Wed, 14 Mar 2001 Andries.Brouwer@cwi.nl wrote:

>>>>> +o  Console Tools      #   0.3.3        # loadkeys -V
>>>>> +o  Mount              #   2.10e        # mount --version
>>>>
>>>> Concerning mount: (i) the version mentioned is too old,
>>
>> Exactly why? Mere missing features don't make for a required
>> upgrade. Version number inflation should be resisted.
...
> These days you can mount several filesystems at the same mount point.
> The old mount does not understand this at all.
> Recent versions of mount act better in this respect,
> even though it is still easy to confuse them.

The rule should be like this:

   List the lowest version number required to get
   2.2.xx-level features while running a 2.4.xx kernel.

Remember what the purpose of the table is. It is a list of REQUIRED
upgrades. Failure to upgrade should result in a broken system. So pppd
must be listed, since somebody changed the kernel API for 2.4.1.

If I run the mount command from Red Hat 6.2, using it as intended
for a 2.2.xx kernel, doesn't everything work? There won't be any
multi-mount confusion because 2.2.xx can't do that anyway. There
isn't any problem with NFSv3 either, since 2.2.xx lacks NFSv3.

Basically I ask: would existing scripts for a 2.2.xx kernel break?
If the old mount can still do what it used to do, then "mount" need
not be listed at all.

