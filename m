Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWIDRIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWIDRIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIDRIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:08:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51940 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964939AbWIDRIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:08:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=Jxb2O+Wjseg5QHxmlvaOaNsoUmndYrF2eSxhP9iJulzVk3BSxb78QQNg4JMDdCRQlfbYSBNy/l4bj5QOAUS/9MBDqR88qI02txjt3CxIlhutPwX45qe5rcKbE6UskaXyc+6tdICOrtSfkRRKWAH7zvlxr4/lEMeJF5mVg21TTns=
Date: Mon, 4 Sep 2006 19:09:29 +0200
From: Luca <kronos.it@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Message-ID: <20060904170929.GA27986@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(trimming CC list)

Paul Mackerras <paulus@samba.org> ha scritto:
 Alon Bar-Lev writes:
> 
>> Current implementation stores a static command-line
>> buffer allocated to COMMAND_LINE_SIZE size. Most
>> architectures stores two copies of this buffer, one
>> for future reference and one for parameter parsing.
> 
> Under what circumstances do we actually need a command line of more
> than 256 bytes?
> 
> It seems to me that if 256 bytes isn't enough, we should take a deep
> breath, step back, and think about whether there might be a better way
> to pass whatever information it is that's using up so much of the
> command line.

Well, if you want to set a parameter of a builtin module you have to
use:
        modulename.parameter=whatever

which can use a lot of space... I suppose that with an "everything
builtin" kernel and a few modules to tune you can get near the limit.

Luca
-- 
Home: http://kronoz.cjb.net
Il tempo speso
a coltivare sogni
non è sprecato.
