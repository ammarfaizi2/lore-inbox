Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266314AbUFQBBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUFQBBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUFQBBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:01:52 -0400
Received: from main.gmane.org ([80.91.224.249]:50869 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266314AbUFQBBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:01:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: mode data=journal in ext3. Is it safe to use?
Date: Thu, 17 Jun 2004 10:51:54 +1000
Message-ID: <871xkfroph.fsf@enki.rimspace.net>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	<1087322976.1874.36.camel@pla.lokal.lan>
	<40D06C0B.7020005@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203-217-29-45.perm.iinet.net.au
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEUAAABNQ1V2fJRwboa5
 t6lhXHeMlJ0YFRbc2cL7+uAVDDkqAAACZUlEQVR4nFXTv3ObMBQHcO46eLXqyuzi4LqCIrerW4WD
 UVbkzBVESTarOR9zLiQn5ro59N9WhJ9lMaePvu9ZwPM8zxOCCCG4ELj7BT7wvf4ipJMks/Zy18sA
 3C1z/Gjd1YZMMDACxliQr8Y0nRDBtB5AYIGPNTVdxL4LKNgAUODdVUqbD7B3TsaESFIZjfDH9R+B
 HMIAZ00vLWETYJQQVJqp1ghEICK4ooO8zpBId+YyGxLvmI/nSFCChRq7X/gECCFOSjpEWoFnCPgx
 M/0Ju8MPEEQycC2GdWvxlFDS9S7VDve15uYoSPh1Capt/xyLMYEkijcgYmtdb4V7K0WwAKAPx0Lk
 PlD5/4lKQ7rfNHvAr9qfMwSxfjL1PTR/fcjzOYFcqS/mB9yY+lel87kHCgTY0nuwMVla6AeJFgA3
 an3SuGzs/hGNcJCEQBF7ngaFsS9mAiRhCJn7yioNMvuSzoAgEuzkecDXmX2VC8Dub3nemZx0bp+X
 cECuki7r21XePicTqPAzcpW0Bt9Wubk/oGgAGT5FXQvXfZXVbJEonrqEd/JWPn3jaAHngFVrd7fS
 WeoCagSpkajWK+2vzlS5gBxBAUT0eqP2nzY0RUqpBTAd31D6e0tTNYMs/ISdCafXxxv6tgB1d5vE
 kNMiojfZe7QAGaPQTU9J6S6/LBJlKmUIE7yjlGZWlTNQqmIAiRP3ot4e0nQAtzENGXC16tJ97OVF
 LSAgXGWm7oa9tlPCUIn4zs1zmnfzYesB3M4Uhbykpmz6WRjAdCDdFBaPbWvNEoyMFGPVd9s2Dpol
 IBVD0G3+mAS3+A/7Wh8nJqB5AwAAAABJRU5ErkJggg==
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
Cancel-Lock: sha1:tKs9WRY8nWyiV5RPCoxjf0p8F/U=
Cc: Ext3-users@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2004, Timothy Miller wrote:
> Petter Larsen wrote:
>
>> Data integrity is much more important for us than speed.
>
> You might want to consider ReiserFS or one of the others which were
> designed with journaling in mind.  And I hope you're using RAID1 or
> RAID5.

I must admit, that isn't quite the response that I would have expected
for those requirements. :)

ReiserFS, XFS and (presumably) JFS all have considerably better
performance than ext3, for most tasks, because they were indeed designed
with journaling in mind.

OTOH, ReiserFS had an extremely long period of instability, and was
build by a group who felt that a working fsck was something you put
together after you got the filesystem working.

This, combined with the occasional "ReiserFS 3 ate my data" reports and
the reluctance of the developers to adapt to the 4K kernel stacks in
2.6.recent, would leave me hesitant to recommend it as "more
trustworthy" than ext3.


XFS, with the "null out data on recovery" mode, is less reliable than
ext3, full stop. It routinely destroys data in real world situations, a
secure, but irritating, choice.


ext3 remains the only journaling filesystem that I would, personally,
put any great degree of faith in, since it is still developed in a
cautious and safe fashion, and has a focus on getting the tools to
verify correctness in place before enabling kernel-side features.


Obviously, your millage may vary on these topics, as presumably have
your experiences.

Regards,
        Daniel
-- 
Advertising may be described as the science of arresting the human
intelligence long enough to get money from it.
        -- Stephen Leacock

