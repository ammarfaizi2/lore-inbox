Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSJXLcy>; Thu, 24 Oct 2002 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSJXLcy>; Thu, 24 Oct 2002 07:32:54 -0400
Received: from k100-23.bas1.dbn.dublin.eircom.net ([159.134.100.23]:55302 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S265400AbSJXLcx>;
	Thu, 24 Oct 2002 07:32:53 -0400
Message-ID: <3DB7DB79.7010003@corvil.com>
Date: Thu, 24 Oct 2002 12:37:29 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> 	<3DB6FF24.9B50A7C0@digeo.com> <1035405140.13083.268.camel@spc9.esa.lanl.gov> <3DB764B0.3010204@namesys.com> <ap8g19$8k4$1@forge.intermeta.de>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> Hans Reiser <reiser@namesys.com> writes:
> 
>>simple tests like this.  We recently ran into one with tar recognizing 
>>that it was writing to /dev/null, and optimizing for it.
> 
> As stated in the info document. It is there for a reason (Amanda).
> 
> --- cut ---
>    When the archive is being created to `/dev/null', GNU `tar' tries to
> minimize input and output operations.  The Amanda backup system, when
> used with GNU `tar', has an initial sizing pass which uses this feature.
> --- cut ---

IMHO /dev/null shouldn't be used for this. What's wrong
with Amanda doing: ln -s /dev/null /dev/drop
Then optimizing tars can use /dev/drop to not write()
and non-optimizing tars will still work as expected?

Pádraig.

