Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRBQKzq>; Sat, 17 Feb 2001 05:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131196AbRBQKzg>; Sat, 17 Feb 2001 05:55:36 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:59654 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S131143AbRBQKzY>; Sat, 17 Feb 2001 05:55:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>
	<m1lmr98c5t.fsf@frodo.biederman.org>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 17 Feb 2001 11:47:20 +0100
In-Reply-To: <m1lmr98c5t.fsf@frodo.biederman.org>
Message-ID: <tgvgq9mvrb.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> There is another much more effective solution in the works.  The C
> standard allows bounds checking of arrays.

The C standard does not allow reliable bounds checking on {signed,
unsigned, vanilla} char arrays, because the corresponding pointers can
address the individual bytes in each object, even the object which
follows the array.  To implement things in an efficient manner, you
need fat pointers, which would make sizeof (long) /= sizeof (void *),
which would break quite some software, I think.

IMHO, C is a hopeless case in this area.  Fortunately, there is a
number of other programming languages out there which do permit proper
bounds checking on arrays (and have strong, static typing and other
gizmos which make shooting yourself into the foot unintentionally a
bit more difficult).

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
