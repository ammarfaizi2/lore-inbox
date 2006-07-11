Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWGKTux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWGKTux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGKTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:50:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:42306 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932108AbWGKTuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:50:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jd59PLU56pgx/Ts2Zc551tx5CG8dzxAF251Ec/6iJVHF2kbu6zw0g9s18uR4ugGSLhlI8E7VWCfKHV3pJaXJDlHdhK/CgxKy7KC0gxbTEAiRK+U7U+SKzrJIOnhEx3O0VII2UuGbIJg6pP2kUlpzcRJD3rN5CTXJ3Ez2Dr8b6aE=
Message-ID: <a36005b50607111250k70598c31nbc9c0de661dba9e6@mail.gmail.com>
Date: Tue, 11 Jul 2006 12:50:50 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
Cc: "Cedric Le Goater" <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Kirill Korotaev" <dev@openvz.org>,
       "Andrey Savochkin" <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Herbert Poetzl" <herbert@13thfloor.at>,
       "Sam Vilain" <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       "Dave Hansen" <haveblue@us.ibm.com>
In-Reply-To: <44B3EDBA.4090109@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711075051.382004000@localhost.localdomain>
	 <44B3EA16.1090208@zytor.com> <44B3ED3B.3010401@fr.ibm.com>
	 <44B3EDBA.4090109@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, H. Peter Anvin <hpa@zytor.com> wrote:
> How about execveu()?  -n looked a bit weird to me, mostly because the
> "le" form would be execlen() which looks like something completely
> different...

I would prefer a more general parameter.  With this extension it is
expected to have six new interfaces.  I really don't want to repeat
this if somebody comes up with yet another nice extension.

So, how about generalizing the parameter.  Make is a 'flags'
parameter, assign a number of bits to the unshare functionality and
leave the rest available.  Use a 'f' suffix, perhaps.  Then in future
more bits can be defined and, if necessary, additional parameters can
be added depending on set flags.  The userspace prototypes can then if
absolutely necessary be extended with an ellipsis.  Not nice but not
as bad as adding more and more intefaces.
