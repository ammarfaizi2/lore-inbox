Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWJJDOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWJJDOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWJJDNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:13:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26285 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964927AbWJJDNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:13:12 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] xdr annotations: NFSv2 server
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX83L-0004FU-91@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:13:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs2acl.c         |   18 ++++++-----
 fs/nfsd/nfsxdr.c          |   72 +++++++++++++++++++++++----------------------
 include/linux/nfsd/nfsd.h |    2 +
 include/linux/nfsd/xdr.h  |   50 ++++++++++++++++---------------
 4 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 8d48616..fd5397d 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -158,7 +158,7 @@ static __be32 nfsacld_proc_access(struct
 /*
  * XDR decode functions
  */
-static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclargs *argp)
 {
 	if (!(p = nfs2svc_decode_fh(p, &argp->fh)))
@@ -169,7 +169,7 @@ static int nfsaclsvc_decode_getaclargs(s
 }
 
 
-static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_setaclargs *argp)
 {
 	struct kvec *head = rqstp->rq_arg.head;
@@ -194,7 +194,7 @@ static int nfsaclsvc_decode_setaclargs(s
 	return (n > 0);
 }
 
-static int nfsaclsvc_decode_fhandleargs(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd_fhandle *argp)
 {
 	if (!(p = nfs2svc_decode_fh(p, &argp->fh)))
@@ -202,7 +202,7 @@ static int nfsaclsvc_decode_fhandleargs(
 	return xdr_argsize_check(rqstp, p);
 }
 
-static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_accessargs *argp)
 {
 	if (!(p = nfs2svc_decode_fh(p, &argp->fh)))
@@ -217,7 +217,7 @@ static int nfsaclsvc_decode_accessargs(s
  */
 
 /* GETACL */
-static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclres *resp)
 {
 	struct dentry *dentry = resp->fh.fh_dentry;
@@ -259,7 +259,7 @@ static int nfsaclsvc_encode_getaclres(st
 	return 1;
 }
 
-static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd_attrstat *resp)
 {
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh);
@@ -267,7 +267,7 @@ static int nfsaclsvc_encode_attrstatres(
 }
 
 /* ACCESS */
-static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_accessres *resp)
 {
 	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh);
@@ -278,7 +278,7 @@ static int nfsaclsvc_encode_accessres(st
 /*
  * XDR release functions
  */
-static int nfsaclsvc_release_getacl(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_release_getacl(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd3_getaclres *resp)
 {
 	fh_put(&resp->fh);
@@ -287,7 +287,7 @@ static int nfsaclsvc_release_getacl(stru
 	return 1;
 }
 
-static int nfsaclsvc_release_fhandle(struct svc_rqst *rqstp, u32 *p,
+static int nfsaclsvc_release_fhandle(struct svc_rqst *rqstp, __be32 *p,
 		struct nfsd_fhandle *resp)
 {
 	fh_put(&resp->fh);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 1135c0d..56ebb14 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -37,8 +37,8 @@ static u32	nfs_ftypes[] = {
 /*
  * XDR functions for basic NFS types
  */
-static u32 *
-decode_fh(u32 *p, struct svc_fh *fhp)
+static __be32 *
+decode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	fh_init(fhp, NFS_FHSIZE);
 	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
@@ -50,13 +50,13 @@ decode_fh(u32 *p, struct svc_fh *fhp)
 }
 
 /* Helper function for NFSv2 ACL code */
-u32 *nfs2svc_decode_fh(u32 *p, struct svc_fh *fhp)
+__be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	return decode_fh(p, fhp);
 }
 
-static inline u32 *
-encode_fh(u32 *p, struct svc_fh *fhp)
+static inline __be32 *
+encode_fh(__be32 *p, struct svc_fh *fhp)
 {
 	memcpy(p, &fhp->fh_handle.fh_base, NFS_FHSIZE);
 	return p + (NFS_FHSIZE>> 2);
@@ -66,8 +66,8 @@ encode_fh(u32 *p, struct svc_fh *fhp)
  * Decode a file name and make sure that the path contains
  * no slashes or null bytes.
  */
-static inline u32 *
-decode_filename(u32 *p, char **namp, int *lenp)
+static inline __be32 *
+decode_filename(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
 	int		i;
@@ -82,8 +82,8 @@ decode_filename(u32 *p, char **namp, int
 	return p;
 }
 
-static inline u32 *
-decode_pathname(u32 *p, char **namp, int *lenp)
+static inline __be32 *
+decode_pathname(__be32 *p, char **namp, int *lenp)
 {
 	char		*name;
 	int		i;
@@ -98,8 +98,8 @@ decode_pathname(u32 *p, char **namp, int
 	return p;
 }
 
-static inline u32 *
-decode_sattr(u32 *p, struct iattr *iap)
+static inline __be32 *
+decode_sattr(__be32 *p, struct iattr *iap)
 {
 	u32	tmp, tmp1;
 
@@ -151,8 +151,8 @@ decode_sattr(u32 *p, struct iattr *iap)
 	return p;
 }
 
-static u32 *
-encode_fattr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp,
+static __be32 *
+encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	     struct kstat *stat)
 {
 	struct dentry	*dentry = fhp->fh_dentry;
@@ -195,7 +195,7 @@ encode_fattr(struct svc_rqst *rqstp, u32
 }
 
 /* Helper function for NFSv2 ACL code */
-u32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp)
+__be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct kstat stat;
 	vfs_getattr(fhp->fh_export->ex_mnt, fhp->fh_dentry, &stat);
@@ -206,13 +206,13 @@ u32 *nfs2svc_encode_fattr(struct svc_rqs
  * XDR decode functions
  */
 int
-nfssvc_decode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nfssvc_decode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_argsize_check(rqstp, p);
 }
 
 int
-nfssvc_decode_fhandle(struct svc_rqst *rqstp, u32 *p, struct nfsd_fhandle *args)
+nfssvc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p, struct nfsd_fhandle *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
@@ -220,7 +220,7 @@ nfssvc_decode_fhandle(struct svc_rqst *r
 }
 
 int
-nfssvc_decode_sattrargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_sattrargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -231,7 +231,7 @@ nfssvc_decode_sattrargs(struct svc_rqst 
 }
 
 int
-nfssvc_decode_diropargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_diropargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -242,7 +242,7 @@ nfssvc_decode_diropargs(struct svc_rqst 
 }
 
 int
-nfssvc_decode_readargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_readargs *args)
 {
 	unsigned int len;
@@ -273,7 +273,7 @@ nfssvc_decode_readargs(struct svc_rqst *
 }
 
 int
-nfssvc_decode_writeargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_writeargs *args)
 {
 	unsigned int len;
@@ -303,7 +303,7 @@ nfssvc_decode_writeargs(struct svc_rqst 
 }
 
 int
-nfssvc_decode_createargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_createargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_createargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh))
@@ -315,7 +315,7 @@ nfssvc_decode_createargs(struct svc_rqst
 }
 
 int
-nfssvc_decode_renameargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_renameargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_renameargs *args)
 {
 	if (!(p = decode_fh(p, &args->ffh))
@@ -328,7 +328,7 @@ nfssvc_decode_renameargs(struct svc_rqst
 }
 
 int
-nfssvc_decode_readlinkargs(struct svc_rqst *rqstp, u32 *p, struct nfsd_readlinkargs *args)
+nfssvc_decode_readlinkargs(struct svc_rqst *rqstp, __be32 *p, struct nfsd_readlinkargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
 		return 0;
@@ -338,7 +338,7 @@ nfssvc_decode_readlinkargs(struct svc_rq
 }
 
 int
-nfssvc_decode_linkargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_linkargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_linkargs *args)
 {
 	if (!(p = decode_fh(p, &args->ffh))
@@ -350,7 +350,7 @@ nfssvc_decode_linkargs(struct svc_rqst *
 }
 
 int
-nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_symlinkargs *args)
 {
 	if (!(p = decode_fh(p, &args->ffh))
@@ -363,7 +363,7 @@ nfssvc_decode_symlinkargs(struct svc_rqs
 }
 
 int
-nfssvc_decode_readdirargs(struct svc_rqst *rqstp, u32 *p,
+nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_readdirargs *args)
 {
 	if (!(p = decode_fh(p, &args->fh)))
@@ -382,13 +382,13 @@ nfssvc_decode_readdirargs(struct svc_rqs
  * XDR encode functions
  */
 int
-nfssvc_encode_void(struct svc_rqst *rqstp, u32 *p, void *dummy)
+nfssvc_encode_void(struct svc_rqst *rqstp, __be32 *p, void *dummy)
 {
 	return xdr_ressize_check(rqstp, p);
 }
 
 int
-nfssvc_encode_attrstat(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_attrstat *resp)
 {
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
@@ -396,7 +396,7 @@ nfssvc_encode_attrstat(struct svc_rqst *
 }
 
 int
-nfssvc_encode_diropres(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_diropres *resp)
 {
 	p = encode_fh(p, &resp->fh);
@@ -405,7 +405,7 @@ nfssvc_encode_diropres(struct svc_rqst *
 }
 
 int
-nfssvc_encode_readlinkres(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_readlinkres *resp)
 {
 	*p++ = htonl(resp->len);
@@ -421,7 +421,7 @@ nfssvc_encode_readlinkres(struct svc_rqs
 }
 
 int
-nfssvc_encode_readres(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_readres *resp)
 {
 	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
@@ -440,7 +440,7 @@ nfssvc_encode_readres(struct svc_rqst *r
 }
 
 int
-nfssvc_encode_readdirres(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_readdirres *resp)
 {
 	xdr_ressize_check(rqstp, p);
@@ -453,7 +453,7 @@ nfssvc_encode_readdirres(struct svc_rqst
 }
 
 int
-nfssvc_encode_statfsres(struct svc_rqst *rqstp, u32 *p,
+nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_statfsres *resp)
 {
 	struct kstatfs	*stat = &resp->stats;
@@ -471,7 +471,7 @@ nfssvc_encode_entry(struct readdir_cd *c
 		    int namlen, loff_t offset, ino_t ino, unsigned int d_type)
 {
 	struct nfsd_readdirres *cd = container_of(ccd, struct nfsd_readdirres, common);
-	u32	*p = cd->buffer;
+	__be32	*p = cd->buffer;
 	int	buflen, slen;
 
 	/*
@@ -497,7 +497,7 @@ nfssvc_encode_entry(struct readdir_cd *c
 	*p++ = htonl((u32) ino);		/* file id */
 	p    = xdr_encode_array(p, name, namlen);/* name length & name */
 	cd->offset = p;			/* remember pointer */
-	*p++ = ~(u32) 0;		/* offset of next entry */
+	*p++ = htonl(~0U);		/* offset of next entry */
 
 	cd->buflen = buflen;
 	cd->buffer = p;
@@ -509,7 +509,7 @@ nfssvc_encode_entry(struct readdir_cd *c
  * XDR release functions
  */
 int
-nfssvc_release_fhandle(struct svc_rqst *rqstp, u32 *p,
+nfssvc_release_fhandle(struct svc_rqst *rqstp, __be32 *p,
 					struct nfsd_fhandle *resp)
 {
 	fh_put(&resp->fh);
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index d0d4aae..2f75160 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -50,7 +50,7 @@ #define MAY_REMOVE		(MAY_EXEC|MAY_WRITE|
  * Callback function for readdir
  */
 struct readdir_cd {
-	int			err;	/* 0, nfserr, or nfserr_eof */
+	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 typedef int		(*encode_dent_fn)(struct readdir_cd *, const char *,
 						int, loff_t, ino_t, unsigned int);
diff --git a/include/linux/nfsd/xdr.h b/include/linux/nfsd/xdr.h
index 0e53de8..877192d 100644
--- a/include/linux/nfsd/xdr.h
+++ b/include/linux/nfsd/xdr.h
@@ -81,7 +81,7 @@ struct nfsd_readdirargs {
 	struct svc_fh		fh;
 	__u32			cookie;
 	__u32			count;
-	u32 *			buffer;
+	__be32 *		buffer;
 };
 
 struct nfsd_attrstat {
@@ -108,9 +108,9 @@ struct nfsd_readdirres {
 	int			count;
 
 	struct readdir_cd	common;
-	u32 *			buffer;
+	__be32 *		buffer;
 	int			buflen;
-	u32 *			offset;
+	__be32 *		offset;
 };
 
 struct nfsd_statfsres {
@@ -135,43 +135,43 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_void(struct svc_rqst *, u32 *, void *);
-int nfssvc_decode_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
-int nfssvc_decode_sattrargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_void(struct svc_rqst *, __be32 *, void *);
+int nfssvc_decode_fhandle(struct svc_rqst *, __be32 *, struct nfsd_fhandle *);
+int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *,
 				struct nfsd_sattrargs *);
-int nfssvc_decode_diropargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *,
 				struct nfsd_diropargs *);
-int nfssvc_decode_readargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_readargs(struct svc_rqst *, __be32 *,
 				struct nfsd_readargs *);
-int nfssvc_decode_writeargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_writeargs(struct svc_rqst *, __be32 *,
 				struct nfsd_writeargs *);
-int nfssvc_decode_createargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_createargs(struct svc_rqst *, __be32 *,
 				struct nfsd_createargs *);
-int nfssvc_decode_renameargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_renameargs(struct svc_rqst *, __be32 *,
 				struct nfsd_renameargs *);
-int nfssvc_decode_readlinkargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_readlinkargs(struct svc_rqst *, __be32 *,
 				struct nfsd_readlinkargs *);
-int nfssvc_decode_linkargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *,
 				struct nfsd_linkargs *);
-int nfssvc_decode_symlinkargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *,
 				struct nfsd_symlinkargs *);
-int nfssvc_decode_readdirargs(struct svc_rqst *, u32 *,
+int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *,
 				struct nfsd_readdirargs *);
-int nfssvc_encode_void(struct svc_rqst *, u32 *, void *);
-int nfssvc_encode_attrstat(struct svc_rqst *, u32 *, struct nfsd_attrstat *);
-int nfssvc_encode_diropres(struct svc_rqst *, u32 *, struct nfsd_diropres *);
-int nfssvc_encode_readlinkres(struct svc_rqst *, u32 *, struct nfsd_readlinkres *);
-int nfssvc_encode_readres(struct svc_rqst *, u32 *, struct nfsd_readres *);
-int nfssvc_encode_statfsres(struct svc_rqst *, u32 *, struct nfsd_statfsres *);
-int nfssvc_encode_readdirres(struct svc_rqst *, u32 *, struct nfsd_readdirres *);
+int nfssvc_encode_void(struct svc_rqst *, __be32 *, void *);
+int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *, struct nfsd_attrstat *);
+int nfssvc_encode_diropres(struct svc_rqst *, __be32 *, struct nfsd_diropres *);
+int nfssvc_encode_readlinkres(struct svc_rqst *, __be32 *, struct nfsd_readlinkres *);
+int nfssvc_encode_readres(struct svc_rqst *, __be32 *, struct nfsd_readres *);
+int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *, struct nfsd_statfsres *);
+int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *, struct nfsd_readdirres *);
 
 int nfssvc_encode_entry(struct readdir_cd *, const char *name,
 				int namlen, loff_t offset, ino_t ino, unsigned int);
 
-int nfssvc_release_fhandle(struct svc_rqst *, u32 *, struct nfsd_fhandle *);
+int nfssvc_release_fhandle(struct svc_rqst *, __be32 *, struct nfsd_fhandle *);
 
 /* Helper functions for NFSv2 ACL code */
-u32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, u32 *p, struct svc_fh *fhp);
-u32 *nfs2svc_decode_fh(u32 *p, struct svc_fh *fhp);
+__be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp);
+__be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp);
 
 #endif /* LINUX_NFSD_H */
-- 
1.4.2.GIT


