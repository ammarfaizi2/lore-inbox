Return-Path: <linux-kernel-owner+w=401wt.eu-S1751393AbXAPTwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXAPTwi (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAPTwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:52:38 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:55642 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751393AbXAPTwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:52:37 -0500
Message-ID: <45AD2D00.2040904@scientia.net>
Date: Tue, 16 Jan 2007 20:52:32 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, ak@suse.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org>
In-Reply-To: <20070116180154.GA1335@tuatara.stupidest.org>
Content-Type: multipart/mixed;
 boundary="------------010306030003020506020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306030003020506020800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Chris Wedgwood wrote:
> right now i'm thinking if we can't figure out which cpu/bios
> combinations are safe we might almost be better off doing iommu=soft
> for *all* k8 stuff except for those that are whitelisted; though this
> seems extremely drastic
>   
I agree,... it seems drastic, but this is the only really secure solution.
But it seems that none of the responsible developers read our thread or
the bugreport and gave his opinion about the issue.

> it's not clear if this only affect nvidia based chipsets, the nature
> of the corruption makes me think it's not an iommu software bug (we
> see a few bytes not entire pages corrupted, it's not even clear if
> it's entire cachelines trashed) --- perhaps other vendors have more
> recent bios errata or maybe it's just that nvidia has sold a lot of
> these so they are more visible? (i'm assuming at this point it might
> be some kind of cpu errata that some bioses deal with because some
> mainboards don't ever seem to see this whilst others do)
>   
Well we can hope that Nvidia will find out more (though I'm not too
optimistic).


> in some ways the problem is worse with recent kernels --- because the
> ethernet and sata can address over 4GB and don't use the iommu anymore
> the problem is going to be *much* harder to hit, but still here
> lurking to cause problems for people.
Yes I agree,.. this is a dangerous situation...
But we should not forget about the issue, just because SATA is not
longer affected.

Chris.

--------------010306030003020506020800
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010306030003020506020800--
