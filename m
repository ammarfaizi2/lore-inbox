Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286913AbSABKmN>; Wed, 2 Jan 2002 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286907AbSABKmB>; Wed, 2 Jan 2002 05:42:01 -0500
Received: from sun.fadata.bg ([80.72.64.67]:41489 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S286913AbSABKlx>;
	Wed, 2 Jan 2002 05:41:53 -0500
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <87y9jh3v27.fsf@deneb.enyo.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <87y9jh3v27.fsf@deneb.enyo.de>
Date: 02 Jan 2002 12:41:28 +0200
Message-ID: <874rm5yqzr.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Florian" == Florian Weimer <fw@deneb.enyo.de> writes:

Florian> Momchil Velikov <velco@fadata.bg> writes:
>> -		strcpy(namep, RELOC("linux,phandle"));
>> +		memcpy (namep, RELOC("linux,phandle"), sizeof("linux,phandle"));

Florian> Doesn't this still trigger undefined behavior, as far as the C
Florian> standard is concerned?  It's probably a better idea to fix the linker,
Florian> so that it performs proper relocation.

Well, strictly speaking it _is_ undefined, however adding/subtracting
__PAGE_OFFSET is far too common operation and one can resonably expect
to get away with it in the _vast_ majority of cases. IMHO, it is
better to fix the particular case, which triggers the undefined
behaviour, as these cases are bound to be _very_ rare.

Regards,
-velco
