Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSE0Vjx>; Mon, 27 May 2002 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316613AbSE0Vjw>; Mon, 27 May 2002 17:39:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58117 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316592AbSE0Vjv>; Mon, 27 May 2002 17:39:51 -0400
Message-ID: <3CF2A7A0.5030107@zytor.com>
Date: Mon, 27 May 2002 14:39:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk> <acu82e$7qn$1@cesium.transmeta.com> <20020527173306.C15560@redhat.com> <3CF2A648.1070303@zytor.com> <20020527173738.D15560@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Mon, May 27, 2002 at 02:34:00PM -0700, H. Peter Anvin wrote:
> 
>>Doesn't help.  exec() should fail.
> 
> 
> Only if you're out of memory (any sane app nowadays does not allocate 
> memory from data/bss).
> 

.data/.bss is writable, and will need to be allocated to avoid 
overcommitment, so the exec() will fail.

	-hpa


